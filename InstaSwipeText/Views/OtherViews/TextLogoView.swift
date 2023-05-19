//
//  TextLogoView.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 10.03.2023.
//

import SwiftUI

struct TextLogoView: View {
    @EnvironmentObject var settings: EditorSettings
    var size: CGFloat
    var body: some View {
        HStack(spacing: 5) {
            Text("L_CreatedWith".localized())
                .font(.system(size: size, weight: .light, design: .rounded))
                .foregroundColor(settings.colors.additionalColor)
            Text("L_AppName".localized())
                .font(.system(size: size, weight: .heavy, design: .serif))
                .foregroundColor(settings.colors.additionalColor)
        }
    }
}
