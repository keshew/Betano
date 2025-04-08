import SwiftUI

extension Text {
    func Bak(size: CGFloat,
             color: Color = .white)  -> some View {
        self.font(.custom("BakbakOne-Regular", size: size))
            .foregroundColor(color)
    }
}
