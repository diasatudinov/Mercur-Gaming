import SwiftUI

struct SRAchivementsView: View {
    @StateObject var user = UserSR.shared
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var viewModel: SRAchievementsViewModel
    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    HStack(alignment: .top) {
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            Image(.backIconSR)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 100:50)
                        }
                        
                        
                        
                        Spacer()
                        
                        Image(.achieveTextSR)
                            .resizable()
                            .scaledToFit()
                        
                        Spacer()
                        Image(.backIconSR)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 100:50)
                            .opacity(0)
                    }.padding([.top, .horizontal])
                }
                
               
                Spacer()
                
                let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 2)
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(viewModel.achievements, id: \.self) { achieve in
                        achievementItem(item: achieve)
                    }
                }
                
                
                Spacer()
               
            }
        }.background(
            ZStack {
                Image(.appBgSR)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
    }
    
    @ViewBuilder func achievementItem(item: SRAchievement) -> some View {
        ZStack {
            VStack(spacing: 0) {
                Image(item.isAchieved ? item.image:"\(item.image)Off")
                    .resizable()
                    .scaledToFit()
            
            }
            
            VStack {
                Spacer()
                Button {
                    if !item.isAchieved {
                        user.updateUserMoney(for: 100)
                    }
                    viewModel.achieveToggle(item)
                    
                } label: {
                    Image(.priceHundredSR)
                        .resizable()
                        .scaledToFit()
                        .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 100:50)
                }
            }
        }.frame(height: SRDeviceInfo.shared.deviceType == .pad ? 350:200)
    }
    
}