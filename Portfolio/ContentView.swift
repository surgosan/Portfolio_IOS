import SwiftUI

extension Color {
    static var dynamicTheme: Color {
        return Color("dynamicTheme")
    } // Method to call when wanting to get the Dynamic Theme color
}

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme // Setting the users setting as an environment variable

    var dynamicTheme: Color { // Checks if colorScheme == dark. If it is, return orange, else return blue
        colorScheme == .dark ?
        Color(red: 214/255, green: 90/255, blue: 49/255) :
        Color(red: 93/255, green: 139/255, blue: 244/255)
    }
    
    var body: some View {       
        
        ZStack { // Main ZStack
            if colorScheme == .dark { // Check if colorSheme is dark or light and use appropriate
                Color.black.edgesIgnoringSafeArea(.all)
            } else {
                Color.white.edgesIgnoringSafeArea(.all)
            }
            
            TabView {
                Home()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
                About()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("About")
                    }
                
                Projects()
                    .tabItem {
                        Image(systemName: "folder.fill")
                        Text("Projects")
                    }
            }
        } // Main ZStack
    } // Body
} // Structure

#Preview {
    ContentView()
}
