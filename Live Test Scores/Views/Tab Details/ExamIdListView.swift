//
//  ExamIdListView.swift
//  Live Test Scores
//
//  Created by Thomas DiZoglio on 2/1/23.
//

import SwiftUI

struct ExamIdListView: View {

    @EnvironmentObject var scoresData: ScoresViewModel
    var id: Int
    
    var allExamsWithId: [ScoreModel] {
        scoresData.matchingExams(examId: id)
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(allExamsWithId) { score in
                    NavigationLink {
                        ScoreView(score: score)
                    } label: {
                        ScoreView(score: score)
                    }
                }
            }
        }
        .navigationTitle("Exam \(id)")
    }
}
