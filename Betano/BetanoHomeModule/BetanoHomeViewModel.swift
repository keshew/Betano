import SwiftUI

class BetanoHomeViewModel: ObservableObject {
    let contact = BetanoHomeModel()
    @Published var isAdd = false
    @Published var timers: [TimerModel] = []
    @Published var isPrecreatedTimerTapped = false
    @Published var precreatedModel = TimerModel(name: "", category: .precreated, icon: .basket, hour: "", minute: "")
    @Published var userModel = TimerModel(name: "", category: .other, icon: .basket, hour: "", minute: "")
    @Published var isUserTimerTapped = false
    @Published var isSpin = false
    init() {
        loadTimers()
    }
    
    func loadTimers() {
         let manager = UserDefaultsManager()
         timers = manager.retrieveTimers()
     }
}
