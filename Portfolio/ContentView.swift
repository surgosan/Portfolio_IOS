import SwiftUI

extension Color {
    static var dynamicTheme: Color {
        return Color("dynamicTheme")
    } // Method to call when wanting to get the Dynamic Theme color
}

struct ContentView: View {
    @State private var currentLanguageIndex: Int = 0
    @Environment(\.colorScheme) var colorScheme // Setting the users setting as an environment variable

    var dynamicTheme: Color { // Checks if colorScheme == dark. If it is, return orange, else return blue
        colorScheme == .dark ? Color(red: 214/255, green: 90/255, blue: 49/255) : Color(red: 93/255, green: 139/255, blue: 244/255)
    }
    
    let texts = [
            ("System.out.println(\"Hello World\");", "Java"),
            ("printf(\"Hello, World!\");", "C"),
            ("<h1> Hello World </h1>", "HTML"),
            ("--text: \"Hello World\"", "CSS"),
            ("console.log(\"Hello World\");", "JavaScript"),
            ("print(\"Hello World\")", "Swift"),
        ]
    

    var body: some View {
        ZStack { // Use Z Stack to set the background of the app
            if colorScheme == .dark { // Check if colorSheme is dark or light and use appropriate
                Color.black.edgesIgnoringSafeArea(.all)
            } else {
                Color.white.edgesIgnoringSafeArea(.all)
            }
            
            VStack {
                    HStack {
                        Image("portrait") // Insert portrait image
                            .resizable() // Allow to be resized
                            .aspectRatio(contentMode: .fill) // = background-size: fill
                            .frame(width: 80, height: 80) // Size of the object
                            .clipShape(Circle()) // Cut into a circle
                            .overlay(Circle().stroke(dynamicTheme, lineWidth: 1)) // Border
                            .shadow(radius: 10) // Shadow

                            VStack(alignment: .leading) {
                                Text("Sergio")
                                    .font(.title) // Name
                                    .multilineTextAlignment(.leading)
                                
                                Text("Sanchez-Alvarez") // Name
                                    .font(.title2)
                                    .foregroundColor(Color.gray)
                                    .multilineTextAlignment(.leading)
                            }
                    }
                Text("Student | Musician | Programmer")
                
                VStack { // Display "Hello World" in different languages
                    Text(texts[currentLanguageIndex].0) // Hello World
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    HStack { // Language Container
                        Spacer()
                        Text(texts[currentLanguageIndex].1)
                            .font(.caption)
                            .fontWeight(.thin)
                            .multilineTextAlignment(.trailing)
                    }
                }
                .padding(.all, 10.0)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(5.0)
                .onAppear { // Create the timer to iterate over languages
                    Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
                        currentLanguageIndex = (currentLanguageIndex + 1) % texts.count
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
