import SwiftUI

class BetanoCreateAccountViewModel: ObservableObject {
    let contact = BetanoCreateAccountModel()
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var secondPassword: String = ""
    @Published var showRegistrationAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isLogIn = false
    @Published var isGuest = false
    
    let userDefaultsManager = UserDefaultsManager()
    
    func registerUser() {
        if name.isEmpty || email.isEmpty || password.isEmpty || secondPassword.isEmpty {
            alertMessage = "Please enter all fields"
            showRegistrationAlert = true
            return
        }
        
        if password != secondPassword {
            alertMessage = "Passwords are not the same"
            showRegistrationAlert = true
            return
        }
        
        if userDefaultsManager.register(email: email, password: password, nickname: name) {
            isLogIn = true
        } else {
            alertMessage = "Email already exists"
            showRegistrationAlert = true
        }
    }
}
