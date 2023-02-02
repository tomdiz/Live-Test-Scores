//
//  ScoreModel.swift
//  Live Test Scores
//
//  Created by Thomas DiZoglio on 2/1/23.
//

import Foundation

struct ScoreModel: Codable, Hashable, Identifiable {
    
    var id: UUID
    var studentId: String
    var exam: Int
    var score: Double
}

