//
//  SubscriptionView.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 10.03.2023.
//

//
//case day = 0
///// A subscription period unit of a week.
//case week = 1
///// A subscription period unit of a month.
//case month = 2
///// A subscription period unit of a year.
//case year = 3


import SwiftUI
import RevenueCat
import AlertToast
import SwiftUIGIF

struct SubscriptionView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var showLoading: Bool = false
    @State var priceText: String = "€ 2,99"
    @State var periodText: String = "WEEK"
    @State var productTitle: String = "Weakly subscription"
    @State var productDescription: String = "Get access to premium user paid features!"
    
    init() {
       
    }
    
    func setup(){
        guard let product = User.shared.storeProduct,
        let period = product.subscriptionPeriod else { return }
        
        productTitle = product.localizedTitle // "Weakly subscription "
        productDescription = product.localizedDescription // "Get access to premium user paid features!"
        priceText = product.localizedPriceString // "€ 2,99"
        periodText = period.periodToText().uppercased() // "week"
    
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(alignment: .center ,spacing: 20) {
                
                ZStack{
                    VStack(alignment: .center) {
                        SectionTitleView(text: "\("L_PremiumUppercase".localized())", alignment: .center)
                        SubSectionTitleView(text: productDescription, alignment: .center)
                    }
                    HStack() {
                        Spacer()
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .center)
                                .opacity(0.3)
                        }
                    }
                }
                
                GIFImage(name: "box").frame(height: 200).opacity(0.8)
                   
                VStack(spacing: 30) {
                    
                    ArticleView(text: "L_SubscribtionDescription".localized(), alignment: .leading).bold()
                    
                    HStack {

                        Text(priceText)
                            .multilineTextAlignment(.leading)
                            .frame(alignment: .leading)
                            .font(.system(size: 50, weight: .heavy, design: .rounded))
                            
                        
                        Rectangle().foregroundColor(.textColor).frame(width: 4, height: 40, alignment: .center)
                        
                        VStack(alignment: .leading) {
                            Text("L_PER").font(.system(.body, design: .monospaced, weight: .heavy))
                            Text(periodText).font(.system(.title3, design: .monospaced, weight: .heavy))
                        }
                        
                    }.foregroundColor(.textColor)
                        .LightGrayViewStyle()
                }
                
                Button {
                    guard let product = User.shared.storeProduct else { return }
                    showLoading = true
                    Purchases.shared.purchase(product: product) { trans, info, err, ok in
                        if err == nil {
                            User.shared.isProUser = true
                        } else {
                            User.shared.isProUser = false
                        }
                        showLoading = false
                    }
                } label: {
                    Text("L_TryItForFreeLabel".localized())
                }.BlueButtonStyle().lightShadow()

                Text("L_SubscribtionDetails".localized())
                    .multilineTextAlignment(.center)
                    .font(.system(.footnote, design: .rounded, weight: .medium))
                    .foregroundColor(.textColor)
                
                
                ConditionsTermsView()
            }.padding(35)
        }.background(BGColor)
            .onAppear{
                setup()
                AnalyticsWrapper.onScreanAppear("Subscription")
            }
            .toast(isPresenting: $showLoading) {
                AlertToast(type: .loading)
            }
    }
    

    
}
