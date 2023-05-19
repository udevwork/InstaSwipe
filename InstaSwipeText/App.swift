//
//  InstaSwipeTextApp.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 19.02.2023.
//

import SwiftUI
import FirebaseCore
import FirebaseRemoteConfig
import RevenueCat
import SwiftRater // https://github.com/takecian/SwiftRater

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: "appl_wuAXIwjhiGzZaJfIGEVpaiMltWW")
        
        Purchases.shared.getOfferings { offerings, error in
            offerings?.all.forEach({ (key, value) in
               
                value.availablePackages.forEach { pack in
                    if pack.storeProduct.productIdentifier == "weakly_subscription" {
                        User.shared.storeProduct = pack.storeProduct
                    }
                }
                
            })
        }
        
        
       
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            if customerInfo?.entitlements["PRO"]?.isActive == true {
                User.shared.isProUser = true
            }
        }
        
        SwiftRater.daysUntilPrompt = 0
        SwiftRater.usesUntilPrompt = 1
        SwiftRater.significantUsesUntilPrompt = 2
        SwiftRater.daysBeforeReminding = 1
        SwiftRater.showLaterButton = true
        SwiftRater.debugMode = false
        SwiftRater.appLaunched()

        
        return true
    }
    

    
}


class MainViewModel: ObservableObject {
    
    @Published var isLoadingComplete: Bool = false
    @Published var needToPresentOnboarding = false
    @Published var screenTransitionAnimation = false
    
    init() {
        Task {
            try await startFetching()
        }
        
    }
    
    private func startFetching() async throws {
        let rc = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        rc.configSettings = settings
        
        do {
            let config = try await rc.fetchAndActivate()
            switch config {
                case .successFetchedFromRemote:
                    print( rc.configValue(forKey: "appLink").stringValue as Any)
                    DispatchQueue.main.async {
                        
                        self.isLoadingComplete = true
                        self.screenTransitionAnimation.toggle()
                        self.checkIfNeedToShowOnboarding()
                    }
                    
                    return
                case .successUsingPreFetchedData:
                    print( rc.configValue(forKey: "appLink").stringValue as Any)
                    DispatchQueue.main.async {
                        
                        self.isLoadingComplete = true
                        self.screenTransitionAnimation.toggle()
                        self.checkIfNeedToShowOnboarding()
                    }
                    return
                default:
                    print("Error activating")
                    return
            }
        } catch let error {
            print("Error fetching: \(error.localizedDescription)")
        }
    }
    
    func checkIfNeedToShowOnboarding(){
        let OnboardingWasShowed = UserDefaults.standard.bool(forKey: "OnboardingWasShowed")
        if OnboardingWasShowed == false {
            needToPresentOnboarding = true
            self.screenTransitionAnimation.toggle()
        }
    }
    
}


@main
struct InstaSwipeTextApp: App {
    
    @StateObject var settings = EditorSettings()
    @StateObject var model = MainViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        setupNavigationBar()
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if model.isLoadingComplete, model.needToPresentOnboarding == false {
                    NavigationStack {
                        HomeView().environmentObject(settings)
                    }.transition(.opacity)
                }
                
                if model.isLoadingComplete,  model.needToPresentOnboarding {
                    OnboardingView().environmentObject(model).transition(.opacity)
                }
   
                if model.isLoadingComplete == false {
                    LaunchScreenView().transition(.opacity)
                }
            }.preferredColorScheme(.light)
                .animation(.easeInOut, value: model.screenTransitionAnimation)
        }
    }
    
    private func setupNavigationBar(){
//        //Use this if NavigationBarTitle is with Large Font
//        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "CormorantGaramond-Bold", size: 50)!]
//
//        //Use this if NavigationBarTitle is with displayMode = .inline
//        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "CormorantGaramond-Bold", size: 20)!]
    }
}
