// Copyright © 2022 Yuuichi Mizuno. All rights reserved.

import UIKit

class ViewController: UIViewController {

    private lazy var swiftUiView = TasksContainer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}



// MARK: - public
extension ViewController {
    
}



// MARK: - private
extension ViewController {
    
    private func configure() {
         addChildSubSwiftUIView(swiftUiView)
    }
}
