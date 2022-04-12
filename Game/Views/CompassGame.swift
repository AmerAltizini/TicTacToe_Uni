// fetching Geoportal Kassel API and compass UI
import Foundation
import SwiftUI
import Combine

import Foundation

struct Welcome: Codable {
    let type: String
    let features: [Feature]
}
struct Feature: Codable {
    let type: FeatureType
    let id: Int
    let geometry: Geometry
    let properties: Properties
}


//Geometry
struct Geometry: Codable {
    let type: GeometryType
    let coordinates: [Double]
}

enum GeometryType: String, Codable {
    case point = "Point"
}

//Properties
struct Properties: Codable {
    let objectid: Int
    let objekt: String
    let str, hsnr: String?
    let plz: Int?
    let ort: Ort
    let tel: String?
    let link: String?
    let adresse, plzOrt: String
    let geprueft, existiert: JSONNull?

    enum CodingKeys: String, CodingKey {
        case objectid = "OBJECTID"
        case objekt = "Objekt"
        case str = "Str"
        case hsnr = "Hsnr"
        case plz = "PLZ"
        case ort = "Ort"
        case tel = "Tel"
        case link = "Link"
        case adresse = "Adresse"
        case plzOrt = "Plz_Ort"
        case geprueft = "Geprueft"
        case existiert = "Existiert"
    }
}

enum Ort: String, Codable {
    case kassel = "Kassel"
}

enum FeatureType: String, Codable {
    case feature = "Feature"
}

//Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

//URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func welcomeTask(with url: URL, completionHandler: @escaping (Welcome?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

//Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
struct Marker: Hashable {
    let degrees: Double
    let label: String

    init(degrees: Double, label: String = "") {
        self.degrees = degrees
        self.label = label
    }

    func degreeText() -> String {
        return String(format: "%.0f", self.degrees)
    }
// compass direction markers
    static func markers() -> [Marker] {
        return [
            Marker(degrees: 0, label: "N"),
            Marker(degrees: 30),
            Marker(degrees: 60),
            Marker(degrees: 90, label: "E"),
            Marker(degrees: 120),
            Marker(degrees: 150),
            Marker(degrees: 180, label: "S"),
            Marker(degrees: 210),
            Marker(degrees: 240),
            Marker(degrees: 270, label: "W"),
            Marker(degrees: 300),
            Marker(degrees: 330)
        ]
    }
}

struct CompassMarkerView: View {
    let marker: Marker
    let compassDegress: Double

    var body: some View {
        VStack {
            Text(marker.degreeText())
                .fontWeight(.light)
                .rotationEffect(self.textAngle())
            
            Capsule()
                .frame(width: self.capsuleWidth(),
                       height: self.capsuleHeight())
                .foregroundColor(self.capsuleColor())
            
            Text(marker.label)
                .fontWeight(.bold)
                .rotationEffect(self.textAngle())
                .padding(.bottom, 180)
        }.rotationEffect(Angle(degrees: marker.degrees))
    }
    
    private func capsuleWidth() -> CGFloat {
        return self.marker.degrees == 0 ? 7 : 3
    }

    private func capsuleHeight() -> CGFloat {
        return self.marker.degrees == 0 ? 45 : 30
    }

    private func capsuleColor() -> Color {
        return self.marker.degrees == 0 ? .red : .gray
    }

    private func textAngle() -> Angle {
        return Angle(degrees: -self.compassDegress - self.marker.degrees)
    }
}
// compass heading UI
struct CompassGame : View {
    @ObservedObject var compassHeading = CompassHeading()
    var body: some View {
        VStack {
            VStack {
                        
            DataContentView()
            
            Capsule()
                .frame(width: 5,
                       height: 50)

            ZStack {
                ForEach(Marker.markers(), id: \.self) { marker in
                    CompassMarkerView(marker: marker,
                                      compassDegress: self.compassHeading.degrees)
                }
            }
            .frame(width: 300,
                   height: 300)
            .rotationEffect(Angle(degrees: self.compassHeading.degrees))
            .statusBar(hidden: true)
        }.onAppear {
    }
}
}
// dummy array for the compass game
struct DataContentView: View {
    static let place = ["Friedrichsplatz","Hauptbahnhof","Orangerie","Neue Galerie","Schöne Aussicht","Museum Fridericianum (Kunsthalle)","Brüderkirche","Wilhelmsstraße","Holger-Börner-Platz",]

        @State var randomPlace = Self.place.randomElement()!
    var body: some View {
//        NavigationView{
            ZStack{
                Text(randomPlace).foregroundColor(.black).font(.system(size: 35, weight: .heavy, design: .default)).fontWeight(.bold).frame(maxWidth: .infinity, alignment: .center).padding(.bottom,200)
                Spacer()
        }
        
    }
}

    struct Indicator : UIViewRepresentable {
        func makeUIView(context: UIViewRepresentableContext<Indicator>) -> UIActivityIndicatorView {
            let indi = UIActivityIndicatorView(style: .large)
            indi.color = UIColor.red
            return indi
        }
        
        func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Indicator>) {
            uiView.startAnimating()
        }
    }
}
