import SwiftUI

struct LaunchScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            ContentView()
                .transition(.opacity)
        } else {
            ZStack {
                Image("launchscreen")
                Image("cap")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding(.vertical, -250)
                    .padding(.horizontal, -65)
                    .rotationEffect(.degrees(-20))
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}

