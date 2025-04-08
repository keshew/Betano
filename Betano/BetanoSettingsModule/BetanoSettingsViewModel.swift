import SwiftUI

class BetanoSettingsViewModel: ObservableObject {
    let contact = BetanoSettingsModel()
    @Published var isLogOut = false
    @Published var isReminds: Bool {
        didSet {
            UserDefaults.standard.set(isReminds, forKey: "isReminds")
        }
    }
    
    @Published var isNotif: Bool {
        didSet {
            UserDefaults.standard.set(isNotif, forKey: "isNotif")
        }
    }
    
    @Published var isVib: Bool {
          didSet {
              UserDefaults.standard.set(isVib, forKey: "isVib")
          }
      }
    
    init() {
        isVib = UserDefaults.standard.bool(forKey: "isVib")
        isReminds = UserDefaults.standard.bool(forKey: "isReminds")
        isNotif = UserDefaults.standard.bool(forKey: "isNotif")
      }
}
