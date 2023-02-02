//
//  Live_Test_ScoresTests.swift
//  Live Test ScoresTests
//
//  Created by Thomas DiZoglio on 2/1/23.
//

import XCTest
import LDSwiftEventSource
@testable import Live_Test_Scores

final class Live_Test_ScoresTests: XCTestCase, ScoreDataDelegate {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testScoreModelLoaded() {
        let uuid = UUID()
        let studentId = "Bobby.Brown"
        let examId = 900
        let examScore = 0.7543256
        let score = ScoreModel(id: uuid, studentId: studentId, exam: examId, score: examScore)
        XCTAssertEqual(score.id, uuid, "score id must be \(uuid)")
        XCTAssertEqual(score.studentId, studentId, "score student id must be \(studentId)")
        XCTAssertEqual(score.score, examScore, "exam score must be \(examScore)")
    }

    func testScoreHandler() {
        let messageEventData = "{\"studentId\":\"Kelsie_Hansen\",\"exam\":1822,\"score\":0.7216929903265412}"
        let scoreHandler = ScoreHandler()
        scoreHandler.delegate = self
        let dict = scoreHandler.convertToDictionary(text: messageEventData)
        XCTAssertNotNil(dict)
        XCTAssertEqual(dict!["studentId"] as! String, "Kelsie_Hansen", "student Id must be \"Kelsie_Hansen\"")
        XCTAssertEqual(dict!["exam"] as! Int, 1822, "exam must be \(1822)")
        XCTAssertEqual(dict!["score"] as! Double, 0.7216929903265412, "score must be \(0.7216929903265412)")
        let messageEvent = MessageEvent(data:"{\"studentId\":\"Kelsie_Hansen\",\"exam\":2013,\"score\":0.7951870074338622}")
        scoreHandler.onMessage(eventType: "score", messageEvent: messageEvent)
    }

    func onError(error: Error) {
    }

    func scoreReceived(scoreDict: Dictionary<String, Any>) {
        XCTAssertNotNil(scoreDict)
        let examId = scoreDict["exam"] as! Int
        XCTAssertEqual(examId, 2013, "exam must be \(2013)")
        let studentId = scoreDict["studentId"] as! String
        XCTAssertEqual(studentId, "Kelsie_Hansen", "student Id must be \"Kelsie_Hansen\"")
        let score = scoreDict["score"] as? NSNumber
        XCTAssertEqual(score, 0.7951870074338622, "score must be \(0.7951870074338622)")
    }

    func testScoresViewModel() {
        let scoreViewModel = ScoresViewModel()
        XCTAssertEqual(scoreViewModel.studentTestScores.count, 0, "scores must be 0")
        XCTAssertNotNil(scoreViewModel.eventSource)

        let uuid1 = UUID()
        scoreViewModel.studentTestScores.append(ScoreModel(id: uuid1, studentId: "Julie_Frami", exam: 900, score: 0.782328300488538))
        let uuid2 = UUID()
        scoreViewModel.studentTestScores.append(ScoreModel(id: uuid2, studentId: "Julie_Frami", exam: 901, score: 0.436728300488538))
        let uuid3 = UUID()
        scoreViewModel.studentTestScores.append(ScoreModel(id: uuid3, studentId: "Frank.Brown", exam: 901, score: 0.876789283004885))
        let studentScores = scoreViewModel.matchingStudentId(studentId: "Julie_Frami")
        XCTAssertEqual(studentScores.count, 2, "Should be 2 students")
        let examScores = scoreViewModel.matchingExams(examId: 900)
        XCTAssertEqual(examScores.count, 1, "Should be 1 student")
    }
}
