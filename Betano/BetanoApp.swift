import SwiftUI

@main
struct BetanoApp: App {
    var body: some Scene {
        WindowGroup {
            if UserDefaultsManager().isFirstLaunch() {
                BetanoOnboardingView()
            } else {
                if UserDefaultsManager().checkLogin() {
                    BetanoTabBarView()
                } else {
                    BetanoCreateAccountView()
                }
            }
        }
    }
}
