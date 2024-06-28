import SwiftUI

extension Color {
    static var dynamicTheme: Color {
        return Color("dynamicTheme")
    } // Method to call when wanting to get the Dynamic Theme color
}

struct ContentView: View {
    
    var body: some View {
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
                    Image(systemName: "gearshape.fill")
                    Text("Projects")
                }
        }
    } // Body
} // Structure

#Preview {
    ContentView()
}
