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
                return "L_day".localized()
            case .week:
                return "L_week".localized()
            case .month:
                return "L_month".localized()
            case .year:
                return "L_year".localized()
        }
    }
}
