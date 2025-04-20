import Foundation
import SwiftUI

class UserDefaultsManager: ObservableObject {
    private let key = "statDataArray"
    
    let precreatedModel = [TimerModel(name: "Basketball Practice", category: .precreated, icon: .basket, hour: "0", minute: "45"),
                           TimerModel(name: "Running Training", category: .precreated, icon: .run, hour: "0", minute: "30"),
                           TimerModel(name: "Soccer Training", category: .precreated, icon: .soccer, hour: "0", minute: "60"),
                           TimerModel(name: "Gym Training", category: .precreated, icon: .gym, hour: "0", minute: "120")]
    
    func isFirstLaunch() -> Bool {
        let defaults = UserDefaults.standard
        let isFirstLaunch = defaults.bool(forKey: "isFirstLaunch")
        
        if !isFirstLaunch {
            saveTimers(precreatedModel)
            UserDefaults.standard.set(2450, forKey: "points")
            updateCountWheel()
            UserDefaults.standard.set(0, forKey: "timersCompleted")
            UserDefaults.standard.set(0, forKey: "countWheelTapped")
            defaults.set(true, forKey: "isFirstLaunch")
            return true
        }
        
        return false
    }
    
    //MARK: -
    func save(_ array: [StatData]) {
         if let data = try? JSONEncoder().encode(array) {
             UserDefaults.standard.set(data, forKey: key)
         }
     }
     
     func add(_ stat: StatData) {
         var current = fetch()
         current.append(stat)
         save(current)
     }
     
     func fetch() -> [StatData] {
         guard let data = UserDefaults.standard.data(forKey: key),
               let array = try? JSONDecoder().decode([StatData].self, from: data) else {
             return []
         }
         return array
     }
    //MARK: -
    
    func incrementTimersCompleted() {
        var timersCompleted = UserDefaults.standard.integer(forKey: "timersCompleted")
        timersCompleted += 1
        UserDefaults.standard.set(timersCompleted, forKey: "timersCompleted")
    }
    
    func addPoints(_ points: Int) {
        let currentPoints = UserDefaults.standard.integer(forKey: "points")
        UserDefaults.standard.set(currentPoints + points, forKey: "points")
        updateCountWheel()
    }
    
    func calculateCountWheel() -> Int {
        let points = UserDefaults.standard.integer(forKey: "points")
        let maxSpins = points / 1000
        let usedSpins = UserDefaults.standard.integer(forKey: "countWheelTapped")
        
        return max(maxSpins - usedSpins, 0)
    }
    
    func decrementCountWheel() {
        var countWheel = UserDefaults.standard.integer(forKey: "countWheel")
        if countWheel > 0 {
            countWheel -= 1
            UserDefaults.standard.set(countWheel, forKey: "countWheel")
        }
        
        var countWheelTapped = UserDefaults.standard.integer(forKey: "countWheelTapped")
        countWheelTapped += 1
        UserDefaults.standard.set(countWheelTapped, forKey: "countWheelTapped")
    }

    func updateCountWheel() {
        let newCountWheel = calculateCountWheel()
        UserDefaults.standard.set(newCountWheel, forKey: "countWheel")
    }

    func saveTimers(_ timers: [TimerModel]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(timers) {
            UserDefaults.standard.set(encoded, forKey: "savedTimers")
        }
    }
    
    func appendTimer(_ newTimer: TimerModel) {
        var currentTimers = retrieveTimers()
        currentTimers.append(newTimer)
        saveTimers(currentTimers)
    }
    
    func retrieveTimers() -> [TimerModel] {
        if let savedTimers = UserDefaults.standard.data(forKey: "savedTimers") {
            let decoder = JSONDecoder()
            if let loadedTimers = try? decoder.decode([TimerModel].self, from: savedTimers) {
                return loadedTimers
            }
        }
        return []
    }
    
    func calculateTotalMinutesForAllTimers() -> Int {
        let timers = retrieveTimers()
        return timers.reduce(0) { total, timer in
            guard let hours = Int(timer.hour),
                  let minutes = Int(timer.minute) else {
                return total
            }
            
            let timerMinutes = hours * 60 + minutes
            return total + timerMinutes
        }
    }
    
    func enterAsGuest() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "guest")
    }
    
    func isGuest() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "guest")
    }
    
    func quitQuest() {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "guest")
    }
    
    func saveTimerCompletionDate() {
        var completionDates = UserDefaults.standard.array(forKey: "timerCompletionDates") ?? [String]()
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: currentDate)
        
        completionDates.append(formattedDate)
        UserDefaults.standard.set(completionDates, forKey: "timerCompletionDates")
    }
    
    func checkConsecutiveDays() -> Bool {
        let completionDates = UserDefaults.standard.array(forKey: "timerCompletionDates") as? [String] ?? []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var consecutiveDays = 0
        let calendar = Calendar.current
        let today = Date()
        var date = calendar.date(byAdding: .day, value: -1, to: today)!
        
        for _ in 1...6 {
            let formattedDate = dateFormatter.string(from: date)
            
            if completionDates.contains(formattedDate) {
                consecutiveDays += 1
            } else {
                break
            }
            
            date = calendar.date(byAdding: .day, value: -1, to: date)!
        }
        
        return consecutiveDays == 6
    }

    func register(email: String, password: String, nickname: String) -> Bool {
        let userDefaults = UserDefaults.standard
        var storedUsers: [String: [String: String]] = [:]
        
        if let existingUsers = userDefaults.dictionary(forKey: "users") as? [String: [String: String]] {
            storedUsers = existingUsers
        }
        
        if storedUsers[email] != nil {
            return false
        }
        
        storedUsers[email] = ["password": password, "nickname": nickname]
        userDefaults.set(storedUsers, forKey: "users")
        return true
    }

    
    func checkLogin() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "isLoggedIn")
    }
    
    private func saveLoginStatus(_ isLoggedIn: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(isLoggedIn, forKey: "isLoggedIn")
    }
    
    func deleteAccount() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "users")
        saveLoginStatus(false)
        
        let timers = retrieveTimers()
        let precreatedTimers = timers.filter { $0.category == .precreated }
        
        saveTimers(precreatedTimers)
    }
    
    func getNickname(for email: String) -> String? {
        let defaults = UserDefaults.standard
        if let storedUsers = defaults.dictionary(forKey: "users") as? [String: [String: String]] {
            return storedUsers[email]?["nickname"]
        }
        return nil
    }
    
    func getEmail() -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "currentEmail")
    }
    
    func logout() {
        saveLoginStatus(false)
        
        let timers = retrieveTimers()
        let precreatedTimers = timers.filter { $0.category == .precreated }
        
        saveTimers(precreatedTimers)
    }
    
    func saveCurrentEmail(_ email: String) {
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "currentEmail")
    }
    
    func login(email: String, password: String) -> Bool {
        let defaults = UserDefaults.standard
        if let storedUsers = defaults.dictionary(forKey: "users") as? [String: [String: String]] {
            for (storedUsername, storedUser) in storedUsers {
                if email == storedUsername && password == storedUser["password"] {
                    saveLoginStatus(true)
                    saveCurrentEmail(email)
                    return true
                }
            }
        }
        return false
    }
}
