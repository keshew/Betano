import SwiftUI

class BetanoCreateTimerViewModel: ObservableObject {
    let contact = BetanoCreateTimerModel()
    @Published var nameTimer = ""
    @Published var isSport = true
    @Published var isWork = false
    @Published var isOther = false
    @Published var isIcon1 = true
    @Published var isIcon2 = false
    @Published var isIcon3 = false
}
