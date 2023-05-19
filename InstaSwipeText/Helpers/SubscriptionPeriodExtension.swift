//
//  SubscriptionPeriodExtension.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 23.03.2023.
//

import Foundation
import RevenueCat

// TODO: - Make it localized
extension SubscriptionPeriod {
    func periodToText() -> String {
        switch self.unit {
            case .day:
                return "day".localized()
            case .week:
                return "week".localized()
            case .month:
                return "month".localized()
            case .year:
                return "year".localized()
        }
    }
}
