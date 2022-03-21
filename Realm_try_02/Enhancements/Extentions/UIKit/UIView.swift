//  Copyright © 2022 Yuuichi Mizuno. All rights reserved.

import UIKit

extension UIView {
    
    func constraintAroundSuper(padding: CGFloat = 0) {
        guard let superview = superview else  { return }

        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: padding),
            self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: padding),
            self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: padding),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: padding)
        ])
    }
}
