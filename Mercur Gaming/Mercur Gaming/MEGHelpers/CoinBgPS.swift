import SwiftUI

struct CoinBgPS: View {
    @StateObject var user = UserPS.shared
    var body: some View {
        ZStack {
            Image(.moneyViewBgPS)
                .resizable()
                .scaledToFit()
            
            Text("\(user.money)")
                .font(.system(size: PSDeviceInfo.shared.deviceType == .pad ? 58:32, weight: .black))
                .foregroundStyle(.yellow)
                .textCase(.uppercase)
                .offset(x: PSDeviceInfo.shared.deviceType == .pad ? 10:5, y: PSDeviceInfo.shared.deviceType == .pad ? 0:0)
            
            
            
        }.frame(height: PSDeviceInfo.shared.deviceType == .pad ? 120:80)
        
    }
}

#Preview {
    CoinBgPS()
}
