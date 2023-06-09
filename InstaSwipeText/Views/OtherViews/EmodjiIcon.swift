//
//  EmodjiIcon.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 06.05.2023.
//

import SwiftUI

struct EmodjiIcon: View {
    
    var iconText: String
    var color: Color = Color.lightGray
    
    var body: some View {
        Text(iconText)
            .font(.system(size: 30))
            .padding()
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 20 , style: .continuous))

    }
}

struct EmodjiIcon_Previews: PreviewProvider {
    static var previews: some View {
        EmodjiIcon(iconText: "👋")
    }
}
