import SwiftUI

extension Color {
    static var dynamicTheme: Color {
        return Color("dynamicTheme")
    } // Method to call when wanting to get the Dynamic Theme color
}

struct ContentView: View {
    @State private var currentLanguageIndex: Int = 0
    @State private var visitCount: Int?
    @State private var serverURL: String = "https://sanchezalvarez.dev/api"
    @Environment(\.colorScheme) var colorScheme // Setting the users setting as an environment variable

    var dynamicTheme: Color { // Checks if colorScheme == dark. If it is, return orange, else return blue
        colorScheme == .dark ? 
        Color(red: 214/255, green: 90/255, blue: 49/255) :
        Color(red: 93/255, green: 139/255, blue: 244/255)
    }
    
    let languagePreviews = [
            ("System.out.println(\"Hello World\");", "Java"),
            ("printf(\"Hello, World!\");", "C"),
            ("<h1> Hello World </h1>", "HTML"),
            ("--text: \"Hello World\"", "CSS"),
            ("console.log(\"Hello World\");", "JavaScript"),
            ("print(\"Hello World\")", "Swift"),
        ]
    
    
    struct VisitResponse: Codable {
            let count: String // Note: count is a String here
        }

        func getVisits() {
            let urlString = "\(serverURL)/visit/getAll"
            guard let url = URL(string: urlString) else {
                print("Invalid URL: \(urlString)")
                self.visitCount = -1
                return
            }

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    self.visitCount = -2
                    return
                }

                guard let data = data else {
                    print("No data received")
                    self.visitCount = -3
                    return
                }

                do {
                    let decodedResponse = try JSONDecoder().decode(VisitResponse.self, from: data)
                    if let count = Int(decodedResponse.count) {
                        DispatchQueue.main.async {
                            self.visitCount = count
                        }
                    } else {
                        print("Failed to convert count to Int")
                        self.visitCount = -4
                    }
                } catch let error {
                    print("Failed to decode response: \(error)")
                    self.visitCount = -4
                }
            }

            task.resume()
        }
    
    func downloadResume() {
            guard let url = Bundle.main.url(forResource: "Sergio Sanchez Alvares", withExtension: "pdf") else {
                print("File not found")
                return
            }

            // Copy the file to the user's document directory
            let fileManager = FileManager.default
            let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            let destinationURL = documentsURL.appendingPathComponent("Sergio Sanchez-Alvares - Resume.pdf")

            do {
                // Remove the existing file if it exists
                if fileManager.fileExists(atPath: destinationURL.path) {
                    try fileManager.removeItem(at: destinationURL)
                }

                // Copy the new file
                try fileManager.copyItem(at: url, to: destinationURL)
                print("File copied to \(destinationURL)")
                // Optionally, you can present a share sheet to share the copied file
                presentShareSheet(url: destinationURL)
            } catch {
                print("Error copying file: \(error)")
            }
        }

    // Function to present share sheet
        func presentShareSheet(url: URL) {
            let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootViewController = windowScene.windows.first?.rootViewController {
                rootViewController.present(activityViewController, animated: true, completion: nil)
            }
        }
    
    
    //---------------------------------------------- MAIN APPLICATION ----------------------------------------------
    var body: some View {
        ZStack { // Use Z Stack to set the background of the app
            if colorScheme == .dark { // Check if colorSheme is dark or light and use appropriate
                Color.black.edgesIgnoringSafeArea(.all)
            } else {
                Color.white.edgesIgnoringSafeArea(.all)
            }
            
            // ------------------------ Main Container ------------------------
            VStack(alignment: .center) {
                // ------------------------ Image & Name ------------------------
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
                // ------------------------ Basic Info ------------------------
                Text("Student | Musician | Programmer")
                
                // ------------------------ Language Previews ------------------------
                VStack { // Display "Hello World" in different languages
                    Text(languagePreviews[currentLanguageIndex].0) // Hello World
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    HStack { // Language Container
                        Spacer()
                        Text(languagePreviews[currentLanguageIndex].1)
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
                        currentLanguageIndex = (currentLanguageIndex + 1) % languagePreviews.count
                    }
                }
                
                // ------------------------ Created in Swift ------------------------
                Group {
                    Text("This app was created in ") +
                    Text("Swift").foregroundStyle(dynamicTheme) +
                    Text(".")
                }
                
                Divider().frame(height: 5)
                
                // ------------------------ Color Scheme Info ------------------------
                VStack {
                    (
                        Text("The ") +
                        Text("color scheme ").foregroundStyle(dynamicTheme) +
                        Text("changes based on if \n you're in dark or light mode.")
                    )
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, 5)
                .padding(.vertical, 1)
                
                Divider().frame(height: 5)
                
                // ------------------------ Visit Count ------------------------
                ZStack {
                    if let visitCount = visitCount {
                        Group {
                            Text("Portfolio Visits: ") +
                            Text("\(visitCount) ").foregroundStyle(dynamicTheme) +
                            Text("since 2023-06-26.")
                        }
                    } else {
                        Text("Fetching ") +
                        Text("Visit ") +
                        Text("Count").foregroundStyle(dynamicTheme)
                    }
                }
                .padding(.vertical, 2)
                .onAppear{
//                    getVisits()  // Call this function when ready to execute queries
                }
                
                Divider().frame(height: 5)
                
                // ------------------------ Resume & Unsplash ------------------------
                HStack(spacing: 0) {
                    // Resume
                    Button(action: {
                        // Call download function
                        downloadResume()
                    }) {
                        Text("Resume Download")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(
                                Image("resumeBackground")
                                    .resizable()
                                    .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fill)
                                    .overlay(Color.black.opacity(0.1))
                            )
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2, x: 2, y: 2)
                            .padding(.horizontal, 2)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    // Unsplash
                    Button(action: {
                        if let url = URL(string: "https://unsplash.com/@surgosan") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Text("View Unsplash Photos")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(
                                Image("unsplashBackground")
                                    .resizable()
                                    .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fill)
                                    .overlay(Color.black.opacity(0.1))
                            )
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2, x: 2, y: 2)
                            .padding(.horizontal, 2)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .frame(height: 100)
                .padding(.vertical, 10)
            }
            .padding() // Main VStack
        } // ZStack background
    }
}

#Preview {
    ContentView()
}
