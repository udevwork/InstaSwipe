//
//  PurchasesHelper.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 20.05.2023.
//

import Foundation
import RevenueCat


class PurchasesHelper {
    
    public static var package: Package? = nil
    public static var storeProduct: StoreProduct? = nil
    public static var promoOffer: PromotionalOffer? = nil
    
    public static func configure() {
        
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: "appl_wuAXIwjhiGzZaJfIGEVpaiMltWW")
        
        // fetch subscription
        Purchases.shared.getOfferings { (offerings, error) in
            if let packages = offerings?.current?.availablePackages {
                if !packages.isEmpty, let firstPackage = packages.first {
                    
                    let product = firstPackage.storeProduct
                    PurchasesHelper.package = firstPackage
                    PurchasesHelper.storeProduct = product
                    
                    // get trial
                    if let discount = product.discounts.first {
                        Purchases.shared.getPromotionalOffer(forProductDiscount: discount, product: product) { (promoOffer, error) in
                            PurchasesHelper.promoOffer = promoOffer
                        }
                    }
                }
            }
        }
    }
    
    public static func eligibility(_ completion: @escaping (IntroEligibilityStatus) -> Void){
        guard let product = PurchasesHelper.storeProduct else { return }
        Purchases.shared.checkTrialOrIntroDiscountEligibility(product: product, completion: completion)
    }
    
    public static func subscribe(_ completion: @escaping PurchaseCompletedBlock){
        guard let product = PurchasesHelper.storeProduct else { return }
        Purchases.shared.purchase(product: product, completion: completion)
    }
    
    public static func isSubscribed(_ completion: @escaping (Bool)->()){
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            completion(customerInfo?.entitlements.all["PRO"]?.isActive ?? false)
        }
    }
    
    public static func trial(_ completion: @escaping PurchaseCompletedBlock){
        guard let promo = PurchasesHelper.promoOffer else { return }
        guard let package = PurchasesHelper.package else { return }
        Purchases.shared.purchase(package: package, promotionalOffer: promo, completion: completion)
    }
    
}

//
//if info?.entitlements.all["PRO"]?.isActive == true {
//    User.shared.isProUser = true
//}
