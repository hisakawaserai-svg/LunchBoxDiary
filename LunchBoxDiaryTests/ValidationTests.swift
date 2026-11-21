//
//  ValidationTests.swift
//  LunchBoxDiary
//
//  Created by h S. on 2026/11/21.
//

import Foundation
import Testing
@testable import LunchBoxDiary

struct ValidationTests {
    
    // 文字のカウント(全角 = 2, 半角 = 1)がうまくいっているか
    @Test(arguments: [
        ("", 0),
        ("abc", 3),
        ("あいう", 6),
        ("aあ", 3),
        ("春の彩り弁当 Lunch 2026 - Fresh Bento Box - Day!", 48),
        ("春の彩り弁当 Lunch 2026 - Fresh Bento Box - Daily", 49),
        ("😃", 2)
    ])
    func checkCount(title: String, expect: Int) {
        let result = validChar(title)
        #expect(expect == result)
    }
    
    // 境界値の検証
    @Test(arguments: [
        ("春の彩り弁当 Lunch 2026 - Fresh Bento Box - Day!", false),
        ("春の彩り弁当 Lunch 2026 - Fresh Bento Box - Daily", true),
    ])
    func checkIssue(title: String, expect: Bool) {
        let val = ValidationIssue.validate(title: title, mainImage: Data(), thumbImage: Data())
        #expect(val.contains(.charLimit) == expect)
    }
}
