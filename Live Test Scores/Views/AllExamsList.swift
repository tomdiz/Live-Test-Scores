//
//  allRecordsList.swift
//  Live Test Scores
//
//  Created by Thomas DiZoglio on 2/1/23.
//

import SwiftUI

struct allRecordsList: View {
    
    @EnvironmentObject var scoresData: ScoresViewModel

    var allScores: [ScoreModel] {
        scoresData.studentTestScores
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(allScores) { score in
                    NavigationLink {
                        ScoreView(score: score)
                    } label: {
                        ScoreView(score: score)
                    }
                }
            }
            .navigationTitle("All Records")
        }
    }
}
