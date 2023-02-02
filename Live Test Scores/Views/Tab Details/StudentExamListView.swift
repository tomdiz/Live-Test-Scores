//
//  StudentExamListView.swift
//  Live Test Scores
//
//  Created by Thomas DiZoglio on 2/1/23.
//

import SwiftUI

struct StudentExamListView: View {
    @EnvironmentObject var scoresData: ScoresViewModel
    var id: String
    
    var allStudentExams: [ScoreModel] {
        scoresData.matchingStudentId(studentId: id)
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(allStudentExams) { score in
                    NavigationLink {
                        ScoreView(score: score)
                    } label: {
                        ScoreView(score: score)
                    }
                }
            }
        }
        .navigationTitle("\(id) exams")
    }
}
