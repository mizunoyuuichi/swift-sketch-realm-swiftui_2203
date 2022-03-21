//  Copyright © 2022 Yuuichi Mizuno. All rights reserved.

import SwiftUI

extension View {
    
    // MARK: drop

    func onDrop<T: NSItemProviderReading>(_ key: String, _ entityClass: T.Type, operation: ((_ target: T)->())?) -> AnyView {
        AnyView(
            onDrop(of: [key], isTargeted: nil, perform: { (providers: [NSItemProvider]) -> Bool in
                if let provider = providers.first( where: {$0.hasItemConformingToTypeIdentifier(key)} ) {
                   provider.loadObject(ofClass: T.self) { (dropped, _) in
                        guard let dropped = dropped as? T else { return }
                        DispatchQueue.main.async {
                            operation?(dropped)
                        }
                   }
                }
                return true
            })
        )
    }
    /// when realm object can't encode, use this
    func onDrop(_ key: String, operation: (()->())?) -> AnyView {
        AnyView(
            onDrop(of: [key], isTargeted: nil, perform: { (providers: [NSItemProvider]) -> Bool in
                DispatchQueue.main.async {
                    operation?()
                }
                return true
            })
        )
    }
    
    
    func onTap(operation: (()->())?) -> AnyView {
        AnyView(
            gesture( TapGesture(count: 1).onEnded({ _ in
                operation?()
            }) )
        )
    }
}
