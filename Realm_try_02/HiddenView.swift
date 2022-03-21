// Copyright © 2022 Yuuichi Mizuno. All rights reserved.

import SwiftUI

struct HiddenView: View {
    var body: some View {
        Text("").frame(width: .zero, height: .zero)
    }
}

struct HiddenView_Previews: PreviewProvider {
    static var previews: some View {
        HiddenView()
    }
}
