import SwiftUI

class BetanoLogInViewModel: ObservableObject {
    let contact = BetanoLogInModel()
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showLoginAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isTab = false
    @Published var isGuest = false
    
    let userDefaultsManager = UserDefaultsManager()
    
    func loginUser() {
        if email.isEmpty || password.isEmpty {
            alertMessage = "Please enter all fileds"
            showLoginAlert = true
            return
        }
        
        if userDefaultsManager.login(email: email, password: password) {
            isTab = true
        } else {
            alertMessage = "Invalid email or password"
            showLoginAlert = true
        }
    }
}
