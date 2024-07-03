//
//  Projects.swift
//  Portfolio
//
//  Created by Sergio Sanchez-Alvares on 6/28/24.
//

import SwiftUI

struct Projects: View {
    struct project: Hashable {
        let title: String
        let tags: [String]
        let description: String
        let image: String
        var externalLink: URL?
        let background: Color
    }
    
    let projects: [project] = [
        project(
            title: "ESP32-S3 Force Based Applications",
            tags: ["C", "Micro-Controllers", "ESP32", "Circuits"],
            description: "From a drink coaster than lights up when you place a drink on it, to a chair that turns on a computer; There are endless possibilities to what you could do with a micro-controller and a force resistor.",
            image: "s3forcebased",
            background: Color.orange
        ),
        
        project(
            title: "ESP32-S3 DC Motors and Joystick",
            tags: ["C" ,"Micro-Controllers", "ESP32", "Circuits"],
            description: "I explore the basics of controlling motors via a joystick and potentiometer. This project helped me better understand circuits, I2C connections, and micro-controllers.",
            image: "s3motorsjoy",
            background: Color.blue
        ),
        
        project(
            title: "Kennesaw State University AUV Team",
            tags: ["HTML", "CSS", "JavaScript"],
            description: "The Kennesaw State University AUV Team website serves as the front face for potential investors. I worked on the website alone and created it from scratch while advising the team, and official RoboSub regulations.",
            image: "ksuAUV",
            externalLink: URL(string: "https://ksuauv.com/"),
            background: Color.green
        ),
        
        project(
            title: "Bespoked Bikes Management Site",
            tags: ["HTML", "CSS", "JavaScript", "VueJS", "MySQL"],
            description: "This full stack application allows for the creation, retrieval and updating of information on a database. It also displays data on a table for ease of use",
            image: "bespoked",
            background: Color.red
        ),
        
        project(
            title: "Original Portfolio IOS App",
            tags: ["Swift"],
            description: "In order to learn mobile development for IOS, I recreated my portfolio as an IOS app using Swift and XCode.",
            image: "oldIOS",
            background: Color.gray
        ),
        
        project(
            title: "Original Portfolio",
            tags: ["HTML", "CSS", "JavaScript"],
            description: "This is the original version of this portfolio. This is one of the projects I used to familiarize myself with web development. Note that this project is not stable anymore, but available to view.",
            image: "oldPortfolio",
            background: Color.orange
        ),
        
        project(
            title: "Bunk-a-Biker Website Demo",
            tags: ["HTML", "CSS", "JavaScript", "Google APIs"],
            description: "I created a modern version of the Bunk-A-Biker website that helped me learn how to utilize and implement apis. I experimented with different designs and maps in order to best display pins and locations.",
            image: "babHome",
            background: Color.blue
        ),
        
        project(
            title: "Application Hub",
            tags: ["Java", "JavaFX"],
            description: "I created a simple desktop application for minor tasks. These include tasks that would require using a calculator, but I have the desktop application do it all for me.",
            image: "applicationHub",
            background: Color.green
        ),

        project(
            title: "Chess Master SWE Team Project",
            tags: ["Java", "JavaFX"],
            description: "For our Intro to Software Engineering class, our small team created a desktop application to manage a chess tournament. I handled about 90% of the backend for this project. This included the databases and handling of data.",
            image: "chessMaster",
            background: Color.red
        )
    ]
    
// --------------------------------------------------- CONTENT VIEW --------------------------------------------------
    var body: some View {
        ScrollView { // Main Scroll View
            VStack(alignment: .leading) {
                Text("Projects")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                ForEach(projects, id: \.self) { project in
                    VStack(alignment: .leading) { // Main Project VStack
                        // Image
                        Image(project.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                        Text(project.title) // Title
                            .font(.title2)
                            .padding(.horizontal, 5)
                        
                        HStack { // Tags and Link
                            ForEach(project.tags, id: \.self) { tag in // Tags
                                Text(tag)
                                    .padding(.vertical, 3)
                                    .padding(.horizontal, 8)
                                    .font(.footnote)
                                    .background(project.background.opacity(0.8))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            
                            Spacer()
                            
                            // if Link
                            if let link = project.externalLink {
                                Button(action: {
                                    if UIApplication.shared.canOpenURL(link) {
                                        UIApplication.shared.open(link)
                                    }
                                }) {
                                    Image(systemName: "link")
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, 5)
                                                
                        Text(project.description)
                            .font(.body)
                            .padding(.horizontal, 5)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Divider()
                        .background(Color.white)
                }
                .padding(.bottom, 25)
            }
        } // Main Scroll view
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    Projects()
}
