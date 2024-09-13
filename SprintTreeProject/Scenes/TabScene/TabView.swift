//
//  TabView.swift
//  SprintTreeProject
//
//  Created by Richard Essemiah on 12/09/2024.
//

import SwiftUI

struct TabScene: View {
    var body: some View {
      Text("")
        TabView {
            HomeView()
                .tabItem {
                    HStack {
                        Text("Home")
                        Image(systemName: "house.fill")
                        
                    }
                }
            
            ProfileView()
                .tabItem {
                    VStack {
                        Text("Profile")
                        Image(systemName: "person.fill")
                        
                    }
                }
            
            ProfileView()
                .tabItem {
                    VStack {
                        Text("Settings")
                        Image(systemName: "gear")
                        
                    }
                }
        }
    }
}

#Preview {
    TabScene()
}
