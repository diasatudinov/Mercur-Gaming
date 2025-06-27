//
//  CoinBgPS.swift
//  Mercur Gaming
//
//


import SwiftUI

struct CoinBgPS: View {
    @StateObject var user = UserPS.shared
    var body: some View {
        ZStack {
            Image(.moneyViewBgMEG)
                .resizable()
                .scaledToFit()
            
            Text("\(user.money)")
                .font(.system(size: ITTPDeviceInfo.shared.deviceType == .pad ? 58:32, weight: .black))
                .foregroundStyle(.black)
                .textCase(.uppercase)
                .offset(x: ITTPDeviceInfo.shared.deviceType == .pad ? 10:5, y: ITTPDeviceInfo.shared.deviceType == .pad ? 0:0)
            
            
            
        }.frame(height: ITTPDeviceInfo.shared.deviceType == .pad ? 120:80)
        
    }
}

#Preview {
    CoinBgPS()
}
