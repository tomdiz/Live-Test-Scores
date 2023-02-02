//
//  Live_Test_ScoresApp.swift
//  Live Test Scores
//
//  Created by Thomas DiZoglio on 2/1/23.
//

import SwiftUI

@main
struct Live_Test_ScoresApp: App {

    @StateObject private var scoresData = ScoresViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(scoresData)
        }
    }
}
