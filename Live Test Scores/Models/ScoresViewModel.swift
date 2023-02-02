//
//  ScoresViewModel.swift
//  Live Test Scores
//
//  Created by Thomas DiZoglio on 2/1/23.
//

import Foundation
import LDSwiftEventSource

import Combine

protocol ScoreDataDelegate {
    func onError(error: Error)
    func scoreReceived(scoreDict: Dictionary<String, Any>)
}

final class ScoresViewModel: ObservableObject {
    @Published var studentTestScores: [ScoreModel] = []
    var examIdSet: Set<Int> = []
    var studentIdSet: Set<String> = []
    var eventSource: EventSource?
    private var scoreHandler: ScoreHandler!
    
    init() {
        scoreHandler = ScoreHandler()
        scoreHandler.delegate = self
        let url = URL(string: "https://live-test-scores.herokuapp.com/scores")!
        let config = EventSource.Config(handler: scoreHandler, url: url)
        eventSource = EventSource(config: config)
        eventSource!.start()
    }
    
    func matchingExams(examId: Int) -> [ScoreModel] {
        studentTestScores.filter { $0.exam == examId }
    }

    func matchingStudentId(studentId: String) -> [ScoreModel] {
        studentTestScores.filter { $0.studentId == studentId }
    }
}

extension ScoresViewModel: ScoreDataDelegate {
    
    func onError(error: Error) {
        eventSource?.stop()
    }

    func scoreReceived(scoreDict: Dictionary<String, Any>) {
        let examId = scoreDict["exam"] as! Int
        let studentId = scoreDict["studentId"] as! String
        examIdSet.insert(examId)
        studentIdSet.insert(studentId)
        let score = scoreDict["score"] as? NSNumber
        let scoreData = ScoreModel(id: UUID(), studentId: studentId, exam: examId, score: score!.doubleValue)
        DispatchQueue.main.async {
            self.studentTestScores.append(scoreData)
        }
    }
}

class ScoreHandler: EventHandler {

    var delegate:ScoreDataDelegate?
    
    func onOpened() {
        print("onOpened")
    }
    
    func onClosed() {
        print("onClosed")
    }
    
    func onMessage(eventType: String, messageEvent: MessageEvent) {
        print("onMessage->eventType \(eventType), messageEvent: data \(messageEvent.data), lastEventId: \(messageEvent.lastEventId)")
        
        let scoreData = convertToDictionary(text: messageEvent.data)
        delegate?.scoreReceived(scoreDict: scoreData!)
    }
    
    func onComment(comment: String) {
        print("onComment")
    }
    
    func onError(error: Error) {
        print("onError")
        delegate?.onError(error: error)
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
