//
//  LocalizedHelper.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 11.03.2023.
//

import Foundation
import FirebaseRemoteConfig

extension String {
    
    func localized() -> String {
        NSLocalizedString(self, comment: "")
    }
    
    func remote(def: String = "") -> String{
        RemoteConfig.remoteConfig().configValue(forKey: self).stringValue ?? def
    }
    
}
