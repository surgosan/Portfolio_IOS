import SwiftUI

extension Color {
    static var dynamicTheme: Color {
        return Color("dynamicTheme")
    } // Method to call when wanting to get the Dynamic Theme color
}

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme // Setting the users setting as an environment variable

    var dynamicTheme: Color { // Checks if colorScheme == dark. If it is, return orange, else return blue
        colorScheme == .dark ? Color(red: 214/255, green: 90/255, blue: 49/255) : Color(red: 93/255, green: 139/255, blue: 244/255)
    }

    var body: some View {
        ZStack { // Use Z Stack to set the background of the app
            if colorScheme == .dark { // Check if colorSheme is dark or light and use appropriate color
                Color.black.edgesIgnoringSafeArea(.all)
            } else {
                Color.white.edgesIgnoringSafeArea(.all)
            }
            
            VStack {
                    HStack {
                        Image("portrait") // Insert portrait image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 110, height: 110)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(dynamicTheme, lineWidth: 1))
                            .shadow(radius: 10)
                        
                        HStack {
                            Text("S")
                                .font(.system(size: 80, weight: .bold, design: .default))
                                .foregroundColor(dynamicTheme)
                                
                            
                            VStack(alignment: .leading) {
                                Text("ergio")
                                    .font(.title) // Name
                                    .multilineTextAlignment(.leading)
                                
                                Text("anchez-Alvarez") // Name
                                    .font(.title2)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }
                Text("Student | Musician | Programmer")
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
