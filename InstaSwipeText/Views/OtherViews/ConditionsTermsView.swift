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
            
            HStack {
            VStack(alignment: .leading, spacing: 30) {
                
                HStack(spacing: 10) {
                    Image(systemName: "doc.fill")
                    Link(destination: URL(string: "end_user_license_agreement_url".remote())!) {
                        Text("L_LicenseLabel".localized()).multilineTextAlignment(.leading)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                    
                }  .foregroundColor(.buttonBlue)
                    .font(.system(size: 15, weight: .black))
                
                HStack(spacing: 10) {
                    Image(systemName: "doc.fill")
                    Link(destination: URL(string: "privacy_policy_url".remote())!) {
                        Text("L_PrivacyPolicyLabel".localized()).multilineTextAlignment(.leading)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                }  .foregroundColor(.buttonBlue)
                    .font(.system(size: 15, weight: .black))
                
                HStack(spacing: 10) {
                    Image(systemName: "doc.fill")
                    Link(destination: URL(string: "Terms_Conditions_url".remote())!) {
                        Text("L_TermsConditionsLabel".localized()).multilineTextAlignment(.leading)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                } .foregroundColor(.buttonBlue)
                    .font(.system(size: 15, weight: .black))
                Button {
                    Purchases.shared.restorePurchases()
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                        Text("L_restore purchaselabel".localized())
                    }.font(.system(size: 15, weight: .black)).foregroundColor(.buttonRed)
                }
                
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
