//
//  RaterHelper.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 20.05.2023.
//

import Foundation
import SwiftRater


class RaterHelper {
    public static func configure() {
        SwiftRater.daysUntilPrompt = 0
        SwiftRater.usesUntilPrompt = 1
        SwiftRater.significantUsesUntilPrompt = 2
        SwiftRater.daysBeforeReminding = 1
        SwiftRater.showLaterButton = true
        SwiftRater.debugMode = false
        SwiftRater.appLaunched()

    }
}
