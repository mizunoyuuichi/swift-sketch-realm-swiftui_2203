// Copyright © 2022 Yuuichi Mizuno. All rights reserved.

import Foundation

let kYMDNumberFormat = String("yyyyMMdd")

extension DateFormatter {
    
    func japanTime() -> DateFormatter {
        timeZone = TimeZone(identifier: "Asia/Tokyo")
        locale = Locale(identifier: "ja_JP")
        calendar = Calendar(identifier: .gregorian)
        return self
    }
    
    func set(dateFormat: String) -> DateFormatter {
        self.dateFormat = dateFormat
        return self
    }
    
    func YMDNumber() -> DateFormatter {
        return set(dateFormat: kYMDNumberFormat)
    }
}
