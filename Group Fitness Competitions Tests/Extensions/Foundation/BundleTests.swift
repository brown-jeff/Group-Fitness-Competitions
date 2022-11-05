import Foundation
import XCTest

@testable import Group_Fitness_Competitions

final class BundleTests: XCTestCase {
    func testThatNameIsCorrect() {
        XCTAssertEqual(Bundle.main.name, "Group Fitness Competitions")
    }
}
