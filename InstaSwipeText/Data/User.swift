//
//  User.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 22.03.2023.
//

import Foundation
import Combine

class User {

    public static var shared: User = User()
    
    @Published public var isProUser: Bool = false
    
    private init(){
       
    }
    
    func subscribe(_ completion: @escaping (Bool)->()) {
        PurchasesHelper.eligibility { eligibility in
            if eligibility == .eligible {
                PurchasesHelper.trial { trans, info, err, ok in
                    let result = (err == nil)
                    User.shared.isProUser = result
                    completion(result)
                }
            } else {
                PurchasesHelper.subscribe { trans, info, err, ok in
                    let result = (err == nil)
                    User.shared.isProUser = result
                    completion(result)
                }
            }
        }
    }
    
}
