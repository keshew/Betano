import SwiftUI

class BetanoSpinViewModel: ObservableObject {
    let contact = BetanoSpinModel()
    @Published var updateScreen = 1
    @Published var isHome = false
}
