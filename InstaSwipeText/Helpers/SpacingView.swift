//
//  SpacingView.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 10.03.2023.
//

import Foundation
import SwiftUI

struct SpacingView: View {
    
    enum Side {
        case verical, horizontal
    }
    
    var side: Side
    var size: CGFloat
    
    init(side: Side, size: CGFloat) {
        self.side = side
        self.size = size
    }
    
    var body: some View {
        if side == .horizontal {
            Rectangle().frame(width: size, height: 0).background(.clear)
        } else if side == .verical {
            Rectangle().frame(width: 0, height: size).background(.clear)
        }
    }
}
