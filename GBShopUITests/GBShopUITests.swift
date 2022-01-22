//
//  GBShopUITests.swift
//  GBShopUITests
//
//  Created by Ярослав on 27.11.2021.
//

import XCTest

extension XCUIElement {
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        
        self.tap()
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        self.typeText(deleteString)
        self.typeText(text)
    }
}

class GBShopUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testSuccessfulLogin() throws {
        let app = XCUIApplication()
        app.launch()
        app.scrollViews.otherElements.buttons["Войти"].tap()
        
        XCTAssert(app.toolbars["Toolbar"].buttons["lock off"].waitForExistence(timeout: 2.0))
    }
    
    func testFailedLogin() throws {
        let app = XCUIApplication()
        app.launch()
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.textFields["Логин"].tap()
        elementsQuery.textFields["Логин"].clearAndEnterText(text: "Хэллоу")
        app.scrollViews.otherElements.buttons["Войти"].tap()
        
        XCTAssert(app.alerts.firstMatch.waitForExistence(timeout: 2.0))
    }
    
    func testCartCheckout() throws {
        let app = XCUIApplication()
        app.launch()

        let scrollViewsQuery = app.scrollViews
        app.scrollViews.otherElements.buttons["Войти"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts.firstMatch.tap()
        
        scrollViewsQuery.otherElements.firstMatch.swipeUp()
        scrollViewsQuery.otherElements.buttons["В корзину"].tap()
        
        app.alerts["cart_alert"].scrollViews.otherElements.buttons["ok_button"].tap()

        app.navigationBars["Войти в магазин"].buttons["Cart"].tap()
        tablesQuery.buttons["Оформить покупку"].tap()
        
        app.alerts["cart_alert"].scrollViews.otherElements.buttons["ok_button"].tap()
        
        XCTAssert(tablesQuery.staticTexts["Корзина пуста"].waitForExistence(timeout: 2.0))
    }
}
