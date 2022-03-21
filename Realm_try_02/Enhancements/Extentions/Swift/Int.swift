// Copyright © 2022 Yuuichi Mizuno. All rights reserved.

import Foundation

extension String {
    
    // MARK: - cast
    var int: Int? {
        get { Int(self) ?? nil }
    }
    
    var intValue: Int {
        get { Int(self) ?? 0 }
    }
    
    var toI: Int {
        get { self.intValue }
    }
}
