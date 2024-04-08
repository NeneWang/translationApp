//
//  translationAppApp.swift
//  translationApp
//
//  Created by Nene Wang  on 4/6/24.
//

import SwiftUI

@main
struct translationAppApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Label("Translate", systemImage: "textformat")
                    }

                HistoryView()
                    .tabItem {
                        Label("History", systemImage: "clock.arrow.circlepath")
                    }
            }
        }
    }
}
