import XCTest

@testable import Group_Fitness_Competitions

final class PermissionTests: XCTestCase {
    func testThatIdIsCorrect() {
        XCTAssertEqual(Permission.health.id, "health")
        XCTAssertEqual(Permission.notifications.id, "notifications")
    }

    func testThatTitleIsCorrect() {
        XCTAssertEqual(Permission.health.title, "Health")
        XCTAssertEqual(Permission.notifications.title, "Notifications")
    }

    func testThatDescriptionIsCorrect() {
        XCTAssertEqual(Permission.health.description, "So we can count score")
        XCTAssertEqual(Permission.notifications.description, "So you can stay up to date")
    }

    func testThatImageNameIsCorrect() {
        XCTAssertEqual(Permission.health.imageName, Asset.Images.health.name)
        XCTAssertEqual(Permission.notifications.imageName, Asset.Images.notifications.name)
    }
}
