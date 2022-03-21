// Copyright © 2022 Yuuichi Mizuno. All rights reserved.

import Foundation

extension Date {
    
    var YMDNumber: Int { get {
        DateFormatter().japanTime().YMDNumber().string(from: self).toI
    } }
}
