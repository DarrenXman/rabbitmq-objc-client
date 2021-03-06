import XCTest

class TestHelper {

    static func pollUntil(checker: () -> Bool) -> Bool {
        for _ in 1...10 {
            if checker() {
                return true
            } else {
                run(0.5)
            }
        }
        return false
    }

    static func pollUntil(timeout: NSTimeInterval, checker: () -> Bool) -> Bool {
        let startTime = NSDate()
        while NSDate().timeIntervalSinceDate(startTime) < timeout {
            if checker() {
                return true
            } else {
                run(0.5)
            }
        }
        return false
    }

    static func run(time: NSTimeInterval) {
        NSRunLoop.currentRunLoop().runUntilDate(NSDate().dateByAddingTimeInterval(time))
    }

    static func dispatchTimeFromNow(seconds: Double) -> dispatch_time_t {
        return dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
    }

    static func assertEqualBytes(expected: NSData, _ actual: NSData, _ message: String = "") {
        if message == "" {
            XCTAssertEqual(expected, actual, "\n\nBytes not equal:\n\(expected)\n\(actual)")
        } else {
            XCTAssertEqual(expected, actual, message)
        }
    }

    static func frameworkVersion() -> String {
        let bundle = NSBundle(identifier: "io.pivotal.RMQClient")!
        return bundle.infoDictionary!["CFBundleShortVersionString"] as! String
    }

}