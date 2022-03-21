//  Copyright © 2022 Yuuichi Mizuno. All rights reserved.

import UIKit
import SwiftUI


extension UIViewController {

    func addChildSubView(_ addViewController: UIViewController) {
        self.addChild(addViewController)
        self.view.addSubview(addViewController.view)
        addViewController.view.constraintAroundSuper()
        addViewController.didMove(toParent: self)
    }

    func addChildSubSwiftUIView<T>(_ swiftUIView : T) where T : View  {
        addChildSubView(UIHostingController(rootView: swiftUIView))
    }
}
