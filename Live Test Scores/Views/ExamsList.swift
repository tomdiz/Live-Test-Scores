//
//  ExamsList.swift
//  Live Test Scores
//
//  Created by Thomas DiZoglio on 2/1/23.
//

import SwiftUI

struct ExamsList: View {
    
    @EnvironmentObject var scoresData: ScoresViewModel
    
    struct examIdContainer: Identifiable {
        let id = UUID()
        var examID: Int
    }

    var allExamIds: [examIdContainer] {
        var examIdArray = [examIdContainer]()
        for examId in scoresData.examIdSet {
            examIdArray.append(examIdContainer(examID: examId))
        }
        return examIdArray
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(allExamIds) { exam in
                    NavigationLink {
                        ExamIdListView(id: exam.examID)
                    } label: {
                        ExamIDView(id: exam.examID)
                    }
                }
            }
            .navigationTitle("Exams")
        }
    }
}
