//
//  About.swift
//  Portfolio
//
//  Created by Sergio Sanchez-Alvares on 6/28/24.
//

import SwiftUI

// -------------------------------------------------- ABOUT DETAILS --------------------------------------------------
struct aboutDetails: Hashable {
    let title: String
    let content: String
    let imageOne: String
    let imageTwo: String
    let background: Color
}

let aboutList: [aboutDetails] = [
    aboutDetails(
        title: "Overview",
        content: "My name is Sergio Sanchez-Alvares. I live in Georgia, USA where I attend Kennesaw State University. I enjoy programming, music, photography, and motorcycles.",
        imageOne: "overview1",
        imageTwo: "overview2",
        background: Color.orange
    ),
    
    aboutDetails(
        title: "Hobbies",
        content: "I am a musician and perform on the weekends. I ride a an adventure motorcycle, so I like to take trips and off-roading. I also like photography and go out to take photos sometimes. I also really enjoy programming. I never get tired and sometimes just program for fun.",
        imageOne: "hobbies1",
        imageTwo: "hobbies2",
        background: Color.red
    ),
    
    aboutDetails(
        title: "Plans",
        content: "My future plans consist of graduating from Kennesaw State University with a Bachelor of Science in Computer Science, deepening my knowledge in programming and music, and also to travel to Japan.",
        imageOne: "plans1",
        imageTwo: "plans2",
        background: Color.green
    ),
    
    aboutDetails(
        title: "Work Ethic",
        content: "I am well organized and like to work hard and smart. I enjoy problem solving and am independent, but I am always willing to work with others as well.",
        imageOne: "work1",
        imageTwo: "work2",
        background: Color.blue
    ),
    
    aboutDetails(
        title: "Programming Tools",
        content: "I use a few different tools and languages. As for languages, I am confident in HTML, CSS, JavaScript, Java, and Markdown. I also know Swift. However, I am still learning Swift. As for tools, I am familiar with Vue.js for website development and JavaFX for Java front-end. I also use Github, BitBucket, VSCode and Jgrasp. I also use SQL and MySQL. I am familiar with all of these too.",
        imageOne: "tools1",
        imageTwo: "tools2",
        background: Color.orange
    ),
    
    aboutDetails(
        title: "Programming Experience",
        content: "I have a few different projects that I have worked on alone and with others to further my skill set. I have recreated an existing website and I created this portfolio but this is actually the second version. I am the sole web developer of the KSU AUV team and created the website from scratch. I have learned how to work on both front end and back end development with UX/UI, servers, and databases.",
        imageOne: "exp1",
        imageTwo: "exp2",
        background: Color.gray
    )
]


// -------------------------------------------------- TOOLS --------------------------------------------------
struct tool: Hashable {
    let svg: String
    let tooltip: String
}

let programmingTools: [tool] = [
    tool(svg: "HTML", tooltip: "HTML"),
    tool(svg: "CSS", tooltip: "CSS"),
    tool(svg: "JavaScript", tooltip: "JavaScript"),
    tool(svg: "Java", tooltip: "Java"),
    tool(svg: "Swift", tooltip: "Swift"),
    tool(svg: "Markdown", tooltip: "Markdown"),
    tool(svg: "VueJS", tooltip: "VueJS"),
    tool(svg: "MySQL", tooltip: "MySQL"),
    tool(svg: "VS Code", tooltip: "VS Code"),
    tool(svg: "Git", tooltip: "Git"),
    tool(svg: "GitHub", tooltip: "GitHub"),
    tool(svg: "Bitbucket", tooltip: "Bitbucket")
]


struct About: View { // Struct
    @Environment(\.colorScheme) var colorScheme // Setting the users setting as an environment variable
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    
    var dynamicTheme: Color { // Checks if colorScheme == dark. If it is, return orange, else return blue
        colorScheme == .dark ?
        Color(red: 214/255, green: 90/255, blue: 49/255) :
        Color(red: 93/255, green: 139/255, blue: 244/255)
    }
    
    var body: some View { // Body
        ScrollView { // Main ScrollView
            VStack(alignment: .leading) {
                Text("About Me")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                ForEach(aboutList, id: \.self) { aboutDetails in
                    VStack(alignment: .leading) {
                        Text(aboutDetails.title)
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .underline()
                            .padding(.bottom, 5)

                        Text(aboutDetails.content)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 10)
                    }
                    .padding()
                    .background(aboutDetails.background.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.bottom, 10)
                    
                    HStack { // Overview Images
                        Image(aboutDetails.imageOne)
                            .resizable()
                            .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                            .frame(maxWidth: .infinity) // Allow image to take up available space
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        Image(aboutDetails.imageTwo)
                            .resizable()
                            .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                            .frame(maxWidth: .infinity) // Allow image to take up available space
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 10)
                }
            }
            .padding()
            
            Text("Programming Tools")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            

            let numberOfRows = (programmingTools.count + columns.count - 1) / columns.count
            ForEach(0..<numberOfRows, id: \.self) { row in
                let start = row * columns.count
                let end = min(start + columns.count, programmingTools.count)
                let rowItems = programmingTools[start..<end]
                HStack {
                    Spacer()
                    ForEach(rowItems, id: \.self) { tool in
                        VStack {
                            Image(tool.svg)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .padding(.bottom, 5)
                            Text(tool.tooltip)
                                .font(.caption)
                                .frame(maxWidth: .infinity)
                        }
                        .frame(width: 90, height: 100)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    }
                    Spacer()
                }
                .padding(.bottom, 10)
            }
        } // Main ScrollView
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    } // Body
} // Struct

#Preview {
    About()
}
