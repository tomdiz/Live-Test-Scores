    //
//  ContentView.swift
//  Live Test Scores
//
//  Created by Thomas DiZoglio on 2/1/23.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var scoresData: ScoresViewModel
    @State private var selection: Tab = .allRecordsList

    enum Tab {
        case allRecordsList
        case examsIdList
        case studentIdList
    }

    var body: some View {
        TabView(selection: $selection) {
            allRecordsList()
                .tabItem {
                    Label("All", systemImage: "list.bullet")
                }
                .tag(Tab.allRecordsList)
            
            ExamsList()
                .tabItem {
                    Label("Exams", systemImage: "list.bullet")
                }
                .tag(Tab.examsIdList)

            StudentsList()
                .tabItem {
                    Label("Students", systemImage: "list.bullet")
                }
                .tag(Tab.studentIdList)
        }
    }
}
