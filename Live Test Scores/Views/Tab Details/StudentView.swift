//
//  StudentView.swift
//  Live Test Scores
//
//  Created by Thomas DiZoglio on 2/1/23.
//

import SwiftUI

struct StudentView: View {
    @EnvironmentObject var scoresData: ScoresViewModel
    var id: String
    
    var body: some View {
        Text("Student ID: \(id)")
    }
}
