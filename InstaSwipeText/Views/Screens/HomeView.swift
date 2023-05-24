//
//  HomeView.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 10.03.2023.
//

import SwiftUI
import Combine

class HomeModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        User.shared.$isProUser.sink {_ in
            self.objectWillChange.send()
        }.store(in: &subscriptions)
    }
    
    
}

struct HomeView: View {
    
    @Environment(\.openURL) var openURL

    
    @EnvironmentObject var settings: EditorSettings
    @EnvironmentObject var mainModel: MainViewModel

    
    @StateObject var model: HomeModel = HomeModel()
    @Namespace private var namespace
    @State private var showingSheet = false
    @State var item: TemplateProtocol? = nil
    @State var animate: Bool = false
    @State var finish: Bool = false
    
    
    var body: some View {
        ZStack {
            if animate == false {
                ScrollView(.vertical, showsIndicators: false) {
                    
                    Image("homescreenheader")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: 30)
                    
                    VStack (alignment: .leading, spacing: 20) {
                        
                            HStack(spacing: 16) {
                                EmodjiIcon(iconText: "👋")
                                VStack(alignment: .leading, spacing: 1) {
                                    SectionTitleView(text: "L_HomeSectionCreateTitle".localized(), alignment: .leading)
                                    ArticleView(text: "L_HomeSectionCreateSubtitle".localized(), alignment: .leading)
                                }
                            }.padding(.horizontal,16)
                        
                        if "is_app_on_review".remoteBool() == true {
                            ConditionsTermsView()
                        }
                        
                        if User.shared.isProUser == false {
                            ScreenContentView(color: .buttonBlue) {
                         
                                    VStack(alignment: .leading, spacing: 28) {
                                        
                                        VStack(alignment: .leading, spacing: 8) {
                                            SectionTitleView(textColor: .white, text: "L_HomeSectionMainTitle".localized(), alignment: .leading)
                                                .padding(.horizontal, horPadding)
                                            
                                            ArticleView(textColor: .white, text: "L_HomeSectionMainSubtitle".localized()).padding(.horizontal, horPadding)
                                        }
                                        Button {
                                            showingSheet.toggle()
                                        } label: {
                                            Text("L_PremiumUppercase".localized())
                                        }.WhiteButtonStyle()
                                            .sheet(isPresented: $showingSheet) {
                                                SubscriptionView()
                                            }
                                            .padding(.horizontal, horPadding)
                                    }.background {
                                        Image("whiteFigures")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .opacity(0.4)
                                            .scaleEffect(0.9)
                                    }
                                
                            }
                          
                        }
                        
                        if "is_app_on_review".remoteBool() == false {
                            
                            
                            VStack(alignment: .leading,spacing: 10) {
                                SectionTitleView(text: "L_HomeAuthorWeLove".localized(), alignment: .leading)
                                
                                ArticleView(text: "L_HomeExploreAuthor".localized(), alignment: .leading)
                            }.padding(.horizontal,16)
                            if let git = mainModel.git {
                                FavoriteCreatorsView(creators: git.favoriteCreators)
                            }
                            
                            SectionTitleView(text: "L_HomeSectionTemplates".localized(), alignment: .leading)
                                .padding(.horizontal,16)
                            
                        }
                        
                        TemplateMenuView(animate: $animate, namespace: namespace, topitem: $item, needSubscribe: $showingSheet).padding(.horizontal, 16)
                        
                        ScreenContentView(color: .buttonBlue) {
                     
                                VStack(alignment: .leading, spacing: 20) {
                                    
                                    VStack(alignment: .leading, spacing: 8) {
                                        SectionTitleView(textColor: .white, text: "L_HaveQuastions".localized(), alignment: .leading)
                                            .padding(.horizontal, horPadding)
                               
                                    }
                                    Button {
                                        if let url = URL(string: "https://t.me/imbalanceFighter") {
                                            openURL(url)
                                        }
                                    } label: {
                                        Text("L_MailToTelegram".localized())
                                    }.WhiteButtonStyle()
                                        .sheet(isPresented: $showingSheet) {
                                            SubscriptionView()
                                        }
                                        .padding(.horizontal, horPadding)
                                }.background {
                                    Image("emailus")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .opacity(0.4)
                                        .scaleEffect(0.9)
                                }
                            
                        }
                        
                        if "is_app_on_review".remoteBool() == false {
                            ConditionsTermsView()
                        }
                    }
                    
                }  .background(BGColor)
                    .navigationBarHidden(true)
                    .onAppear {
                        AnalyticsWrapper.onScreanAppear("Home")
                    }
            } else {
                ZStack {
                    if finish == false {
                        EditorView(animate: $animate, finish: $finish, topitem: $item, template: item!, namespace: namespace)
                            .environmentObject(settings)
                    } else {
                        ImagesToSavePreviewView(editble: item!, finish:  $finish, namespace: namespace)
                            .environmentObject(settings)
                    }
                }.animation(Animation.easeInOut(duration: 0.25), value: finish)
            }
        }.animation(Animation.easeInOut(duration: 0.25), value: animate)
    }
}



struct HomeView_Previews: PreviewProvider {
    
    @StateObject static var settings = EditorSettings()
    @StateObject static var model = MainViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    static var previews: some View {
        ZStack {
            NavigationStack {
                HomeView()
                    .environmentObject(settings)
                    .environmentObject(model)
            }.transition(.opacity)
            
        }.preferredColorScheme(.light)
            .animation(.easeInOut, value: model.screenTransitionAnimation)
    }
}
