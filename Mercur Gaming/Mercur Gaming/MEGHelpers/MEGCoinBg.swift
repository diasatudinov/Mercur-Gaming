//
//  MEGCoinBg.swift
//  Mercur Gaming
//
//


import SwiftUI

struct MEGCoinBg: View {
    @StateObject var user = UserPS.shared
    var body: some View {
        ZStack {
            Image(.moneyViewBgMEG)
                .resizable()
                .scaledToFit()
            
            Text("\(user.money)")
                .font(.system(size: ITTPDeviceInfo.shared.deviceType == .pad ? 32:16, weight: .black))
                .foregroundStyle(.black)
                .textCase(.uppercase)
            
            
        }.frame(height: ITTPDeviceInfo.shared.deviceType == .pad ? 100:50)
        
    }
}

#Preview {
    MEGCoinBg()
}
