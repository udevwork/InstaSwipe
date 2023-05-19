import Foundation
import FirebaseAnalytics

class AnalyticsWrapper {
    
    static func onPhotoSave(){
        Analytics.logEvent("save_photo", parameters: nil)
    }
    
    static func OnSelectTemplate(_ templateName: String){
        var parameters: [String : Any] = ["template_name": templateName]
        Analytics.logEvent("select_tepmplate", parameters: parameters)
    }
    
    static func onScreanAppear(_ screenName: String){
        var parameters: [String : Any] = ["screen_name": screenName]
        Analytics.logEvent("on_screan_appear", parameters: parameters)
    }
    
}
