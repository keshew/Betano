import SwiftUI

enum CategoryTimer: Codable {
    case sports
    case work
    case other
    case precreated
}

enum IconTimer: String, Codable {
    case showIcon1
    case showIcon2
    case showIcon3
    case basket, run, soccer, gym
}

struct TimerModel: Codable, Identifiable {
    var id = UUID().uuidString
    var name: String
    var category: CategoryTimer
    var icon: IconTimer
    var hour: String
    var minute: String
}

struct BetanoCreateTimerModel {
   
}


