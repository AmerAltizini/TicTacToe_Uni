//
//  ActivityChallengeView.swift

import SwiftUI
import UIKit
import CoreMotion

struct ActivityChallengeView: View {
// declaring the type of activity and the counting of steps
    let activityManager = CMMotionActivityManager()
    let pedometer = CMPedometer()

    @State var isStarted = false
    @State var startDate: Date? = nil
    @State var endDate: Date? = nil
    @State var activityType: String = ""
    @State var stepsCount: String = "0"
// stop and start button
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    if self.isStarted {
                        self.onStop()
                    } else {
                        self.onStart()
                    }
                }) {
                    Text("\(isStarted ? "Stop" : "Start")").frame(minWidth: 0, maxWidth: .infinity)
                }.padding(.all)
                Text("Start Time = \(AppUtils.getFormattedDate(startDate))").padding()
                Text("End Time = \(AppUtils.getFormattedDate(endDate))").padding()
                Text("activityType = \(activityType)").padding()
                Text("stepCount = \(stepsCount)").padding()
                Spacer()
            }.navigationBarTitle("Activity Challenge")
        }.onAppear {
            print("onAppear")
            guard let previousStartDate = AppUtils.getStartDate() else {
                return
            }
            self.onStart(previousStartDate: previousStartDate)
            self.updateStepsCount()
        }
    }
// record start timing
    func onStart(previousStartDate: Date? = nil) {
        isStarted = true
        if previousStartDate != nil {
            startDate = previousStartDate
        } else {
            startDate = Date()
            AppUtils.saveStartDate(startDate!)
        }
        endDate = nil
        activityType = ""
        stepsCount = "0"
        checkAuthorizationStatus()
        startUpdating()
    }
    
    func onStop() {
        isStarted = false
        endDate = Date()
        stopUpdating()
        updateStepsCount()
        AppUtils.clearUserData()
    }

    func startUpdating() {
        if CMMotionActivityManager.isActivityAvailable() {
            startTrackingActivityType()
        } else {
            activityType = "Not available"
        }

        if CMPedometer.isStepCountingAvailable() {
            startCountingSteps()
        } else {
            stepsCount = "Not available"
        }
    }

    func checkAuthorizationStatus() {
        switch CMMotionActivityManager.authorizationStatus() {
        case CMAuthorizationStatus.denied:
            print("Not available")
            onStop()
            activityType = "Not available"
            stepsCount = "Not available"
        default: break
        }
    }

    func stopUpdating() {
        activityManager.stopActivityUpdates()
        pedometer.stopUpdates()
        pedometer.stopEventUpdates()
    }

    func on(error: Error) {
        print(error)
    }
// record stop timing
    func updateStepsCount() {
        guard let startDate = startDate else { return }
        var toDate = Date()
        if endDate != nil {
            toDate = endDate!
        }
        pedometer.queryPedometerData(from: startDate, to: toDate) { (data, error) in
            if let error = error {
                self.on(error: error)
            } else if let pedometerData = data {
//                print(pedometerData)
                self.stepsCount = String(describing: pedometerData.numberOfSteps)
            }
        }
    }
// type of activity
    func startTrackingActivityType() {
        activityManager.startActivityUpdates(to: OperationQueue.main) { activity in
            guard let activity = activity else { return }
            if activity.walking {
                self.activityType = "Walking"
            } else if activity.stationary {
                self.activityType = "Stationary"
            } else if activity.running {
                self.activityType = "Running"
            } else if activity.automotive {
                self.activityType = "Automotive"
            } else if activity.cycling {
                self.activityType = "Cycling"
            }
        }
    }
//step counting function
    func startCountingSteps() {
        guard let startDate = startDate else { return }
        pedometer.startUpdates(from: startDate) { pedometerData, error in
            guard let pedometerData = pedometerData, error == nil else { return }
//            print("startCountingSteps")
//            print(pedometerData)
            self.stepsCount = pedometerData.numberOfSteps.stringValue
        }
    }
}

struct ActivityChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityChallengeView()
    }
}
