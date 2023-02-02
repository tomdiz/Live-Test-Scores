//
//  ExamIDView.swift
//  Live Test Scores
//
//  Created by Thomas DiZoglio on 2/1/23.
//

import SwiftUI

struct ExamIDView: View {

    @EnvironmentObject var scoresData: ScoresViewModel
    var id: Int
    
    var allExams: [ScoreModel] {
        scoresData.matchingExams(examId: id)
    }

    var body: some View {
        Text("Exam ID: \(id)")
    }
}
