import SwiftUI

class BetanoUserTimerViewModel: ObservableObject {
    let contact = BetanoUserTimerModel()
    @Published var isTimerGoing = false
    @Published var isPaused = false
    @Published var progress: Double = 1.0
    @Published var timeString: String = "00:00:00"
    @Published var totalSeconds: Int = 0
    @Published var initialTotalSeconds: Int = 0
    @Published var points: Int = 0
    @Published var calories: Int = 0
    @Published var animateProgress = false
    @Published var isTimerEnd = false
    @Published var isBackHome = false
    private var timer: Timer?
    
    func configureTimer(hours: Int, minutes: Int) {
        initialTotalSeconds = hours * 3600 + minutes * 60
        totalSeconds = 0
        timeString = String(format: "%02d:%02d:%02d", hours, minutes, 0)
        timeString = "00:00:00"
        progress = 0.0
        points = 0
        calories = 0
    }
    
    func startTimer() {
        isTimerGoing = true
        isPaused = false
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if !self.isPaused && self.totalSeconds < self.initialTotalSeconds {
                self.totalSeconds += 1
                
                let hours = self.totalSeconds / 3600
                let minutes = (self.totalSeconds % 3600) / 60
                let seconds = self.totalSeconds % 60
                
                self.timeString = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
                self.progress = Double(self.totalSeconds) / Double(self.initialTotalSeconds)
                if self.totalSeconds % 60 == 0 {
                    self.points += 10
                    self.calories += 1
                }
                
                if self.totalSeconds >= self.initialTotalSeconds {
                    self.timer?.invalidate()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.isTimerEnd = true
                        self.isTimerGoing = false
                        UserDefaultsManager().incrementTimersCompleted()
                        UserDefaultsManager().saveTimerCompletionDate()
                    }
                }
            }
        }
    }
    
    func pauseTimer() {
        isPaused = true
    }
    
    func resumeTimer() {
        isPaused = false
    }
    
    func resetTimer(hours: Int, minutes: Int) {
        isTimerGoing = false
        isPaused = false
        timer?.invalidate()
        configureTimer(hours: hours, minutes: minutes)
    }
}
