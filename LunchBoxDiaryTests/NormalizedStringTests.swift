//
//  NormalizedStringTests.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/22.
//

import Testing
@testable import LunchBoxDiary

struct NormalizedStringTests {
    // normalizedStringの戻り値が前後の空白を取った値がからならnilを返し、値があるなら空白を取った値が返ってくるか
    @Test(arguments: [
        ("", nil),
        (" ", nil),
        ("お弁当", "お弁当"),
        (" お弁当 ", "お弁当")
    ])
    func normalized(str: String, expect: String?) {
        let normalized = normalizedString(str)
        #expect(normalized == expect)
    }
}
