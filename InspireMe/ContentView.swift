//
//  ContentView.swift
//  Motivational
//
//  Created by Rafael Meha on 06/01/2024.
//

import SwiftUI
#if canImport(AppKit)
import AppKit
#endif

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(0..<3) { index in
                OnboardingPage(index: index, selectedTab: $selectedTab)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
    
}


struct OnboardingPage: View {
    let index: Int
    @Binding var selectedTab: Int
    @Environment(\.colorScheme) var colorScheme
    
    var images = ["exclamationmark.3", "info", "heart.fill"]
    var titles = ["Welcome to InspireMe!", "How to setup it", "Thank you!"]
    var subtitles = [
        "Empower Every Moment – InspireMe",
        "Add the widget to your home screen: \n\n 1. Touch and hold an empty area on your home screen until the apps jiggle. \n 2. Tap the Add button (+) in the upper-left corner. \n 3. Search for InspireMe and select the widget. \n 5. Pace the widget and tap Done in the upper-right corner.",
        "Thank you for downloading InspireMe! \n You can now close the app"
    ]

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: images[index])
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(colorScheme == .dark ? .white : .accentColor)

            Text(titles[index])
                .font(.title)
                .fontWeight(.bold)

            Text(subtitles[index])
                .font(.subheadline)
                .foregroundColor(.secondary)

            Spacer()
            
            if index < titles.count - 1 {
                   Button(action: {
                       withAnimation {
                           selectedTab += 1
                       }
                   }) {
                       Text("Continue")
                           .bold()
                           .frame(maxWidth: .infinity)
                           .padding()
                           .foregroundColor(Color.black)
                           .background(Color.white)
                           .cornerRadius(3.0)
                           .overlay(
                               RoundedRectangle(cornerRadius: 3)
                                   .stroke(Color.black, lineWidth: 1)
                           )
                   }
                   .padding()
               } else {
                   Button(action: {
                       exit(0)
                   }) {
                       Text("Thank you!")
                           .bold()
                           .frame(maxWidth: .infinity)
                           .padding()
                           .foregroundColor(Color.black)
                           .background(Color.white)
                           .cornerRadius(3.0)
                           .overlay(
                               RoundedRectangle(cornerRadius: 3)
                                   .stroke(Color.black, lineWidth: 1)
                           )
                   }
                   .padding()
               }
           }
           .padding()
           .tag(index)
    }
}


#Preview {
    ContentView()
}
