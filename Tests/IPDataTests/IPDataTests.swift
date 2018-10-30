import XCTest
@testable import IPData

final class IPDataTests: XCTestCase {
    
    let defaultTimeout: TimeInterval = 30
    let apiKey = ProcessInfo.processInfo.environment["IPDATA_API_KEY"] ?? "test"
    
    override func setUp() {
        IPData.apiKey = apiKey
    }
    
    override func tearDown() {
        IPData.apiKey = nil
    }
    
    func testBadRequest() {
        let expectationLookup = expectation(description: "Lookup")
        
        let ip = "10"
        IPData.lookup(ip: ip) {
            switch $0 {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error as? IPDataError)
                guard let error = error as? IPDataError else {
                    return
                }
                let expectedMessage = "\(ip) does not appear to be an IPv4 or IPv6 address"
                XCTAssertEqual(error.message, expectedMessage)
                switch error {
                case .invalidIP(let message):
                    XCTAssertEqual(message, expectedMessage)
                default:
                    XCTFail()
                }
            }
            expectationLookup.fulfill()
        }
        
        waitForExpectations(timeout: defaultTimeout)
    }
    
    func testUnauthorized() {
        let expectationLookup = expectation(description: "Lookup")
        
        IPData.lookup(apiKey: "") {
            switch $0 {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error as? IPDataError)
                guard let error = error as? IPDataError else {
                    return
                }
                let expectedMessage = "You have not provided a valid API Key."
                XCTAssertEqual(error.message, expectedMessage)
                switch error {
                case .invalidAPIKey(let message):
                    XCTAssertEqual(message, expectedMessage)
                default:
                    XCTFail()
                }
            }
            expectationLookup.fulfill()
        }
        
        waitForExpectations(timeout: defaultTimeout)
    }
    
    func testForbidden() {
        let expectationLookup = expectation(description: "Lookup")
        
        IPData.lookup(apiKey: "a") {
            switch $0 {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error as? IPDataError)
                guard let error = error as? IPDataError else {
                    return
                }
                let expectedMessage = "You have either exceeded your quota or that API key does not exist. Get a free API Key at https://ipdata.co/registration.html or contact support@ipdata.co to upgrade or register for a paid plan at https://ipdata.co/pricing.html."
                XCTAssertEqual(error.message, expectedMessage)
                switch error {
                case .exceededLimit(let message):
                    XCTAssertEqual(message, expectedMessage)
                default:
                    XCTFail()
                }
            }
            expectationLookup.fulfill()
        }
        
        waitForExpectations(timeout: defaultTimeout)
    }
    
    func testLookupMe() {
        let expectationLookup = expectation(description: "Lookup")
        
        IPData.lookup {
            switch $0 {
            case .success(let ipData):
                XCTAssertNotNil(ipData.ip)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectationLookup.fulfill()
        }
        
        waitForExpectations(timeout: defaultTimeout)
    }
    
    func testLookup() {
        let expectationLookup = expectation(description: "Lookup")
        
        let ip = "66.102.160.1"
        IPData.lookup(ip: ip) {
            switch $0 {
            case .success(let ipData):
                XCTAssertEqual(ipData.ip, ip)
                XCTAssertEqual(ipData.carrier?.name, "AT&T")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectationLookup.fulfill()
        }
        
        waitForExpectations(timeout: defaultTimeout)
    }
    
    func testBulkLookup() {
        let expectationLookup = expectation(description: "Lookup")
        
        let ip = "66.102.160.1"
        IPData.lookup(apiKey: "test", bulk: [ip]) {
            switch $0 {
            case .success(let ipsData):
                XCTAssertEqual(ipsData.count, 1)
                XCTAssertEqual(ipsData.first?.ip, ip)
                XCTAssertEqual(ipsData.first?.carrier?.name, "AT&T")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectationLookup.fulfill()
        }
        
        waitForExpectations(timeout: defaultTimeout)
    }
    
    func testCarrier() {
        let expectationLookup = expectation(description: "Lookup")
        
        let ip = "66.102.160.1"
        IPData.carrier(ip: ip) {
            switch $0 {
            case .success(let carrier):
                XCTAssertEqual(carrier.name, "AT&T")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectationLookup.fulfill()
        }
        
        waitForExpectations(timeout: defaultTimeout)
    }

    static var allTests = [
        ("testBadRequest", testBadRequest),
        ("testUnauthorized", testUnauthorized),
        ("testForbidden", testForbidden),
        ("testLookupMe", testLookupMe),
        ("testLookup", testLookup),
        ("testBulkLookup", testBulkLookup),
        ("testCarrier", testCarrier),
    ]
}
