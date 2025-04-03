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

