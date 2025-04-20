import SwiftUI

struct TimerGroup: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let count: Int
}

class BetanoStatisticsViewModel: ObservableObject {
    let contact = BetanoStatisticsModel()
    @Published var isDay = true
    @Published var isWeek = false
    @Published var isMounth = false
    
    var timerGroups: [TimerGroup] {
        groupedTimers(from: filteredStats)
    }
    
    var totalTime: Int {
           filteredStats.reduce(0) { $0 + $1.timeDid }
       }
       
       var sessionsCount: Int {
           filteredStats.count
       }
       
       var totalPoints: Int {
           filteredStats.reduce(0) { $0 + $1.points }
       }
    
    func formatTime(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        return "\(hours)h \(minutes)m"
    }
    
    var groupedByActivity: [(activity: String, image: String, count: Int)] {
        let grouped = Dictionary(grouping: filteredStats, by: { $0.activiry })
        return grouped.map { (activity, stats) in
            (activity: activity, image: stats.first?.image ?? "", count: stats.count)
        }
    }
    
    func groupedTimers(from stats: [StatData]) -> [TimerGroup] {
        let groups = Dictionary(grouping: stats, by: { $0.activiry })
        return groups.map { (key, value) in
            TimerGroup(name: key, image: value.first?.image ?? "", count: value.count)
        }
    }
    
    private let storage = UserDefaultsManager()

     var filteredStats: [StatData] {
         let allStats = storage.fetch()
         let calendar = Calendar.current
         let now = Date()
         
         if isDay {
             return allStats.filter { calendar.isDate($0.date, inSameDayAs: now) }
         } else if isWeek {
             guard let weekAgo = calendar.date(byAdding: .day, value: -6, to: now) else { return [] }
             return allStats.filter { $0.date >= weekAgo && $0.date <= now }
         } else if isMounth {
             guard let monthAgo = calendar.date(byAdding: .month, value: -1, to: now) else { return [] }
             return allStats.filter { $0.date >= monthAgo && $0.date <= now }
         }
         return []
     }
}
