import UIKit
import XCTest
import PlaybasisSDK

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // this is apikey for testing purpose
        PlaybasisSDK.initWithApiKey("987899683", apiSecret: "2304db407eb37a95c7889f5f870c6379", apiUrl: "https://api.pbapp.net")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // this is an example of test case
    func testPlayerAPI_publicPlayerInfo() {
        XCTAssert(true, "Pass")
        
        let expectation = expectationWithDescription("public info for player")
        
        PBPlayerApi.getPublicInfoForPlayerId("jontestuser", completionBlock: { (player) in
            print("done: \(player.playerId)")
            expectation.fulfill()
        }) { (error) in
            print("eror: \(error.message)")
            XCTFail()
        }
        
        waitForExpectationsWithTimeout(5, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
