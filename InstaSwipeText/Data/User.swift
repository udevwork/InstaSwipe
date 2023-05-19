//
//  User.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 22.03.2023.
//

import Foundation
import RevenueCat
import Combine

class User {

    public static var shared: User = User()
    
    @Published public var isProUser: Bool = false
    
    public var storeProduct: StoreProduct? = nil
    
    private init(){
       
    }
}
