import SwiftUI

struct BetanoTabBarView: View {
    @StateObject var betanoTabBarModel =  BetanoTabBarViewModel()
    @State private var selectedTab: CustomTabBar.TabType = .Home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                if selectedTab == .Home {
                    BetanoHomeView()
                } else if selectedTab == .Settings {
                    BetanoSettingsView()
                } else if selectedTab == .Profile {
                    BetanoProfileView()
                }
            }
            .frame(maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 0)
            }
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    BetanoTabBarView()
}
