import SwiftUI

class BetanoOnboardingViewModel: ObservableObject {
    let contact = BetanoOnboardingModel()
    @Published var currentIndex = 0
    @Published var isSign = false
}
