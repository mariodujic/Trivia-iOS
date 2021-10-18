import XCTest

class LobbyUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func test_tap_generate_quiz_button() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Generate Quiz"].tap()
    }
    
    func test_darkTheme_toggle_button() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Toggle dark theme"].tap()
    }
    
    func test_tap_all_picker_buttons() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["25"].tap()
        app.buttons["50"].tap()
        app.buttons["10"].tap()
    }
    
    func test_picker_label_text() {
        let app = XCUIApplication()
        app.launch()
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", "Number of quiz questions")
        let elementQuery = app.staticTexts.containing(predicate)
        XCTAssertTrue(elementQuery.count > 0)
    }
}
