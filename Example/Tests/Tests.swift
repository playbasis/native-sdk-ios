import UIKit
import XCTest
@testable import PlaybasisSDK

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

    // MARK: Auth API

    func testAuthentication() {
        let expectation = self.expectation(description: "auth api")

        PBAuthenticationApi.authenticate({
            (token) in
            print("token: \(String(describing: token.token))")
            expectation.fulfill()
        }) { (error) in
            print("error: \(error.message)")
            XCTFail()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    // MARK: Settings API

    func testGetAppStatus() {
        let expectation = self.expectation(description: "app status api")

        PBSettingApi.getAppStatusWithCompletionBlock({
            (status, appPeriod) in
            print("App Status: \(status)")
            print("App Period: \(String(describing: appPeriod))")
            expectation.fulfill()
        }) { (error) in
            print("error: \(error.message)")
            XCTFail()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    // MARK: Players API

    func testpublicPlayerInfo() {
        let expectation = self.expectation(description: "public info for player")
        
        PBPlayerApi.getPublicInfoForPlayerId("riza", completionBlock: { (player) in
            print("done: \(player.playerId)")
            expectation.fulfill()
        }) { (error) in
            print("eror: \(error.message)")
            XCTFail()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }

    // MARK: Live Feed API

    func testGetRecentActivities() {
        let expectation = self.expectation(description: "Get recent activities")
        let activityForm = PBRecentActivityForm()
        activityForm.playerId = "riza"
        PBLiveFeedApi.getRecentActivitiesWithForm(activityForm, completionBlock: { (activities:[PBRecentActivity]) in
            activities.forEach({ (activity) in
                dump(activity)
            })
            expectation.fulfill()
        }) { (error) in
            print("eror: \(error.message)")
            XCTFail()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
}
