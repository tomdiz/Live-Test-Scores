## SwiftUI mobile app that supports Server-Sent Events

At `https://live-test-scores.herokuapp.com/scores` you'll find a service that follows the [Server-Sent Events](https://html.spec.whatwg.org/multipage/server-sent-events.html#server-sent-events) protocol. You can connect to the service using cURL:

        curl https://live-test-scores.herokuapp.com/scores

Periodically, you'll receive a JSON payload that represents a student's test score (a JavaScript number between 0 and 1), the exam number, and a student ID that uniquely identifies a student. For example:

        event: score
        data: {"exam": 3, "studentId": "foo", score: .991}

This represents that student foo received a score of `.991` on exam #3. 

SwiftUI mobile app that consumes this data, processes it, and provides a simple user interface that exposes the processed results. 

Here are the operations supported in this mobile app:

1. An operation to list all the users that have received at least one exam score.
2. An operation to list all the exam results for a specified student ID.
3. An operation to list all the exams that have been recorded.
4. An operation to list all the results for a specified exam.
