import Combine
import ECKit
import Factory
import XCTest

@testable import Group_Fitness_Competitions

final class HomeViewModelTests: XCTestCase {
    
    private var competitionsManager: CompetitionsManagingMock!
    private var friendsManager: FriendsManagingMock!
    
    private var cancellables: Cancellables!
    
    override func setUp() {
        super.setUp()
        competitionsManager = .init()
        friendsManager = .init()
        cancellables = .init()
        
        Container.competitionsManager.register { self.competitionsManager }
        Container.friendsManager.register { self.friendsManager }
    }
    
    override func tearDown() {
        competitionsManager = nil
        friendsManager = nil
        cancellables = nil
        super.tearDown()
    }
}
