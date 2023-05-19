//
//  ConditionsTermsView.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 22.03.2023.
//

import SwiftUI
import RevenueCat

struct ConditionsTermsView: View {
    var body: some View {
        ScreenContentView {
            
            
            VStack(spacing: 20) {
                Link("L_PrivacyPolicyLabel".localized(),
                     destination: URL(string: "privacy_policy_url".remote())!).bold()
               
                Link("L_TermsConditionsLabel".localized(), destination: URL(string: "Terms_Conditions_url".remote())!).bold()
               
                Button {
                    Purchases.shared.restorePurchases()
                } label: {
                    Text("L_restore purchaselabel".localized()).bold()
                }
            }.frame(maxWidth: .infinity)
                .padding(.horizontal, horPadding)
        }
    }
}

struct ConditionsTermsView_Previews: PreviewProvider {
    static var previews: some View {
        ConditionsTermsView()
    }
}
