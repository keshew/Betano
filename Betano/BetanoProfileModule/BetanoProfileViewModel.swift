import SwiftUI

class BetanoProfileViewModel: ObservableObject {
    let contact = BetanoProfileModel()
    @Published var isConsecutiveDaysCompleted = false
}
