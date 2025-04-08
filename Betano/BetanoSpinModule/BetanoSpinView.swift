import SwiftUI

struct BetanoSpinView: View {
    @StateObject var betanoSpinModel = BetanoSpinViewModel()
    @State private var isSpinning = false
    @State private var spinAngle: Angle = .zero
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.mainBackground)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack(spacing: 20) {
                            Button(action: {
                                betanoSpinModel.isHome = true
                            }) {
                                Circle()
                                    .fill(.secondMain)
                                    .frame(width: 40, height: 40)
                                    .padding(.leading)
                                    .overlay {
                                        Image(.back)
                                            .resizable()
                                            .frame(width: 18, height: 20)
                                            .padding(.leading)
                                    }
                            }
                            
                            Text("Spin & Win")
                                .Bak(size: 20)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 20)
                        
                        HStack(spacing: 140) {
                            Rectangle()
                                .fill(.secondMain)
                                .frame(height: 72)
                                .cornerRadius(12)
                                .padding(.horizontal)
                                .overlay {
                                    VStack {
                                        Text("Your Points")
                                            .Bak(size: 14, color: .secondLabel)
                                        
                                        Text("\(UserDefaults.standard.integer(forKey: "points"))")
                                            .Bak(size: 20)
                                    }
                                }
                            
                            Rectangle()
                                .fill(.secondMain)
                                .frame(height: 72)
                                .cornerRadius(12)
                                .padding(.horizontal)
                                .overlay {
                                    VStack {
                                        Text("Spins Left")
                                            .Bak(size: 14, color: .secondLabel)
                                        
                                        Text("\(UserDefaults.standard.integer(forKey: "countWheel"))")
                                            .Bak(size: 20)
                                    }
                                }
                        }
                        
                        Spacer(minLength: 50)
                        
                        Image(.wheel)
                            .resizable()
                            .frame(width: 310, height: 310)
                            .rotationEffect(spinAngle)
                            .overlay {
                                VStack {
                                    Image(.pin)
                                        .resizable()
                                        .frame(width: 80, height: 70)
                                        .offset(y: -20)
                                    
                                    Spacer()
                                }
                            }
                        
                        Spacer(minLength: 190)
                        
                        if UserDefaults.standard.integer(forKey: "countWheel") > 0 {
                            if !isSpinning {
                                Button(action: {
                                    spinWheel()
                                }) {
                                    Rectangle()
                                        .fill(.mainOrange)
                                        .frame(height: 60)
                                        .cornerRadius(16)
                                        .padding(.horizontal)
                                        .overlay {
                                            Text("SPIN NOW")
                                                .Bak(size: 18)
                                        }
                                }
                            }
                        }
                    }
                    .padding(.top)
                }
            }
            .fullScreenCover(isPresented: $betanoSpinModel.isHome) {
                BetanoTabBarView()
            }
        }
    }
    
    func spinWheel() {
        isSpinning = true
        let winningAngle = Double.random(in: 0...360)
        let newSpinAngle = Angle(degrees: spinAngle.degrees + winningAngle + 360 * 5)
        
        withAnimation(.easeInOut(duration: 5.0)) {
            self.spinAngle = newSpinAngle
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            let finalAngle = spinAngle.degrees.truncatingRemainder(dividingBy: 360)
            let sectorIndex = Int((finalAngle + 22.5) / 45) % 8 + 1
            
            var pointsToAdd: Int = 0
            switch sectorIndex {
            case 1:
                pointsToAdd = 500
            case 2:
                pointsToAdd = 5
            case 3:
                pointsToAdd = 10
            case 5:
                pointsToAdd = 250
            case 6:
                pointsToAdd = 100
            case 7:
                pointsToAdd = 50
            case 8:
                pointsToAdd = 30
            default:
                pointsToAdd = 0
            }
            
            let currentPoints = UserDefaults.standard.integer(forKey: "points")
            UserDefaults.standard.set(currentPoints + pointsToAdd, forKey: "points")
            
            isSpinning = false
            UserDefaultsManager().decrementCountWheel()
            betanoSpinModel.updateScreen = 0
            UserDefaultsManager().updateCountWheel()
        }
    }
}


#Preview {
    BetanoSpinView()
}

