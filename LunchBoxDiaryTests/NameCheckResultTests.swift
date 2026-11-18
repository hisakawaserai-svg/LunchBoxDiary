//
//  NameCheckResultTests.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/18.
//

import Testing
@testable import LunchBoxDiary

struct NameCheckResultTests {
    let existing: [String] = ["運動会", "遠足"]
    
    @Test(arguments: [
        ("", NameCheckResult.empty),
        ("運動会", NameCheckResult.duplicate),
        ("お花見", NameCheckResult.ok)
    ])
    func check(trimmed: String, expect: NameCheckResult) {
        let result = NameCheckResult.checkName(trimmed, existing: existing)
        #expect(expect == result)
    }
}
