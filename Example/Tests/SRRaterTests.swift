import XCTest
import StarRatingControl

final class SRRaterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSetMaximumValue() {
     
        let expectedMaximumValue = 5
        
        let ratingControl = SRRater()
        ratingControl.maximumValue = expectedMaximumValue
        
        XCTAssertEqual(ratingControl.maximumValue, expectedMaximumValue)
    }
    
    func testSetMaximumValueGreaterThan10() {
        
        let expectedMaximumValue = 10
        
        let ratingControl = SRRater()
        ratingControl.maximumValue = 20
        
        XCTAssertEqual(ratingControl.maximumValue, expectedMaximumValue)
    }
    
    func testSetMaximumValueLessThan3() {
        
        let expectedMaximumValue = 3
        
        let ratingControl = SRRater()
        ratingControl.maximumValue = 0
        
        XCTAssertEqual(ratingControl.maximumValue, expectedMaximumValue)
    }
    
    func testSetCurrentValue() {
        
        let expectedCurrentValue = 1
        
        let ratingControl = SRRater()
        ratingControl.value = expectedCurrentValue
        
        XCTAssertEqual(ratingControl.value, expectedCurrentValue)
    }
    
    func testSetCurrentValueLessThan0() {
        
        let expectedCurrentValue = 0
        
        let ratingControl = SRRater()
        ratingControl.value = -1
        
        XCTAssertEqual(ratingControl.value, expectedCurrentValue)
    }
    
    func testSetMaximumValueGreaterThanMaximumValue() {
        
        let expectedCurrentValue = 3
        
        let ratingControl = SRRater()
        ratingControl.value = 10
        
        XCTAssertEqual(ratingControl.value, expectedCurrentValue)
    }
    
    func testChangeMaximumValueToLessThanCurrentValue() {
        
        let expectedCurrentValue = 5
        
        // Setting up the initial state
        let ratingControl = SRRater()
        ratingControl.maximumValue = 10
        ratingControl.value = 10
        
        // Changing the maximum value
        ratingControl.maximumValue = 5
        
        XCTAssertEqual(ratingControl.value, expectedCurrentValue)
    }
    
    func testAccessibilityIncrement() {
     
        let expectedValue = 10
        
        let ratingControl = SRRater()
        ratingControl.maximumValue = 10
        ratingControl.value = 9
        
        ratingControl.accessibilityIncrement()
        
        XCTAssertEqual(ratingControl.value, expectedValue)
    }
    
    func testAccessibilityIncrementAtMaximum() {
        
        let expectedValue = 10
        
        let ratingControl = SRRater()
        ratingControl.maximumValue = 10
        ratingControl.value = 10
        
        ratingControl.accessibilityIncrement()
        
        XCTAssertEqual(ratingControl.value, expectedValue)
    }
    
    func testAccessibilityDecrement() {
        
        let expectedValue = 9
        
        let ratingControl = SRRater()
        ratingControl.maximumValue = 10
        ratingControl.value = 10
        
        ratingControl.accessibilityDecrement()
        
        XCTAssertEqual(ratingControl.value, expectedValue)
    }
    
    func testAccessibilityDecrementAtZero() {
        
        let expectedValue = 0
        
        let ratingControl = SRRater()
        ratingControl.value = 0
        
        ratingControl.accessibilityDecrement()
        
        XCTAssertEqual(ratingControl.value, expectedValue)
    }
}
