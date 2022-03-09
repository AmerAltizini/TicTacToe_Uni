import SwiftUI

struct HomeView: View {
    @State var selection: Int? = nil
    var body: some View {
        ScrollView(.vertical, showsIndicators:false)
        {
            VStack(alignment: .leading, spacing: 8){
                Text("Games").font(.largeTitle).fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
                ZStack(alignment: .bottom) {
                    Image("tic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .cornerRadius(20)
                    HStack(alignment: .center, spacing:5){
                        Text("Tik Tak Toe").foregroundColor(.white).font(.system(size: 25, weight: .heavy, design: .default)).fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
                        
                        NavigationLink(destination: TypeOfGameOptionView(), tag: 1, selection: $selection) {
                            Button(action: {
                                self.selection = 1
                            }){
                                Text("Play")
                                    .font(.system(size: 15, weight: .heavy, design: .default))
                                    .foregroundColor(Color.black).frame(width: 100, height: 30).background(Color.white).cornerRadius(30)
                            }}
                    }.padding()
                }
                ZStack(alignment: .bottom) {
                    Image("mental")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .cornerRadius(20)
                    HStack(alignment: .center, spacing:5){
                        Text("Mental Calculation").foregroundColor(.white).font(.system(size: 25, weight: .heavy, design: .default)).fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
                        
                        NavigationLink(destination: ContenView(), tag: 2, selection: $selection) {
                            Button(action: {
                                self.selection = 2
                            }){
                                Text("Play")
                                    .font(.system(size: 15, weight: .heavy, design: .default))
                                    .foregroundColor(Color.black).frame(width: 100, height: 30).background(Color.white).cornerRadius(30)
                            }}
                    }.padding()
                }
                ZStack(alignment: .bottom) {
                    Image("steps")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .cornerRadius(20)
                    HStack(alignment: .center, spacing:5){
                        Text("Activity Challenge").foregroundColor(.white).font(.system(size: 25, weight: .heavy, design: .default)).fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
                        
                        NavigationLink(destination: ConteView(), tag: 2, selection: $selection) {
                            Button(action: {
                                self.selection = 2
                            }){
                                Text("Play")
                                    .font(.system(size: 15, weight: .heavy, design: .default))
                                    .foregroundColor(Color.black).frame(width: 100, height: 30).background(Color.white).cornerRadius(30)
                            }}
                    }.padding()
                }
            }.padding(.horizontal)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


