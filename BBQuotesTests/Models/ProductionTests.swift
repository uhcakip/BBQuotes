//
//  ProductionTests.swift
//  BBQuotesTests
//
//  Created by Yuna Chou on 2024/9/27.
//

@testable import BBQuotes
import XCTest

class ProductionTests: XCTestCase {
    func testProductionCases() {
        XCTAssertEqual(Production.breakingBad.rawValue, "Breaking Bad")
        XCTAssertEqual(Production.betterCallSaul.rawValue, "Better Call Saul")
    }

    func testBackgroundImageName() {
        XCTAssertEqual(Production.breakingBad.backgroundImageName, "breaking-bad")
        XCTAssertEqual(Production.betterCallSaul.backgroundImageName, "better-call-saul")
    }

    func testButtonColorName() {
        XCTAssertEqual(Production.breakingBad.buttonColorName, "BreakingBadButton")
        XCTAssertEqual(Production.betterCallSaul.buttonColorName, "BetterCallSaulButton")
    }

    func testShadowColorName() {
        XCTAssertEqual(Production.breakingBad.shadowColorName, "BreakingBadShadow")
        XCTAssertEqual(Production.betterCallSaul.shadowColorName, "BetterCallSaulShadow")
    }
}
