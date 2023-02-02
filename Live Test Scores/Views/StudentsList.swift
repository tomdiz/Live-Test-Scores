//
//  StudentsList.swift
//  Live Test Scores
//
//  Created by Thomas DiZoglio on 2/1/23.
//

import SwiftUI

struct StudentsList: View {
    @EnvironmentObject var scoresData: ScoresViewModel
    
    struct studentIdContainer: Identifiable {
        let id = UUID()
        var studentID: String
    }

    var allStudents: [studentIdContainer] {
        var studentArray = [studentIdContainer]()
        for examId in scoresData.studentIdSet {
            studentArray.append(studentIdContainer(studentID: examId))
        }
        return studentArray
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(allStudents) { student in
                    NavigationLink {
                        StudentExamListView(id: student.studentID)
                    } label: {
                        StudentView(id: student.studentID)
                    }
                }
            }
            .navigationTitle("Students")
        }
    }
}
