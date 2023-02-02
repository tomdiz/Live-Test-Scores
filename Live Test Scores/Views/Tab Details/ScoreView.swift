//
//  ScoreView.swift
//  Live Test Scores
//
//  Created by Thomas DiZoglio on 2/1/23.
//

import SwiftUI

struct ScoreView: View {
    var score: ScoreModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Score")
                .font(.headline)
            Text("Student ID: " + score.studentId)
            Text("Exam ID: \(score.exam)")
            Text("Score : \(score.score)")
        }
        .padding()
    }
}
