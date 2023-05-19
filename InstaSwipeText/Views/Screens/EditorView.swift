//
//  ContentView.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 19.02.2023.
//

import SwiftUI
import PhotosUI
import AlertToast
import Combine
import UIKit
import KeyboardObserving

struct EditorView: View {
    
    enum editigView {
        case colors
        case fonts
    }
    
    @EnvironmentObject var settings: EditorSettings

    @Binding var topitem: TemplateProtocol?
    @Binding var animate: Bool
    @Binding var finish: Bool
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var presentAlert = false
    @State private var currentEditor: editigView = .colors

    @State var animateEditor: Bool = false
    @Namespace private var namespaceEditor
    
    var namespace: Namespace.ID
    var editbleImage: AnyView
    var editble: TemplateProtocol
    
    private var screenHeight = UIScreen.main.bounds.height
    
    init(animate: Binding<Bool>,
         finish: Binding<Bool>,
         topitem: Binding<TemplateProtocol?>,
         template: any TemplateProtocol,
         namespace: Namespace.ID) {
        
        self.editbleImage = AnyView((template as! (any View)))
        self.editble = template
        self.namespace = namespace
        _topitem = topitem
        _animate = animate
        _finish = finish
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack{
                VStack () {
                    VStack {
                        Spacer()
                        editbleImage
                            .environmentObject(settings)
                            .aspectRatio(editble.aspectRatio.getAspectRatio(), contentMode: .fit)
                            .matchedGeometryEffect(id: editble.blockNameInMenu, in: namespace)
                        Spacer()
                    }
                    
                    ScreenContentView {
                        
                        EditorHorizontalMenuView(selectedItem: $selectedItem,
                                                 currentEditor: $currentEditor,
                                                 topitem: $topitem,
                                                 animate: $animate,
                                                 animateEditor: $animateEditor,
                                                 finish: $finish,
                                                 editble: editble).environmentObject(settings)
                        
                        
                        
                        ZStack {
                            if currentEditor == .colors {
                                VStack {
                                    SubSectionTitleView(text: "L_SelectColorButtonText".localized()).padding(.horizontal, horPadding)
                                    PaletteBrowser().environmentObject(settings)
                                    Spacer()
                                }.transition(.opacity).matchedGeometryEffect(id: "editor", in: namespaceEditor)
                            }
                            
                            if currentEditor == .fonts {
                                VStack {
                                    SubSectionTitleView(text: "L_ChooseFontButtonText".localized()).padding(.horizontal, horPadding)
                                    FontBrowser().environmentObject(settings)
                                    Spacer()
                                }.transition(.opacity).matchedGeometryEffect(id: "editor", in: namespaceEditor)
                            }
                        }.animation(Animation.spring(), value: animateEditor)
                        
                        
                        
                    }.frame(height: screenHeight/3)
                    
                }
                .background(EditorBGColor)
                .navigationBarHidden(true)
                .ignoresSafeArea(.keyboard)
                if settings.textEditingMode, let text = settings.correnTextFieldViewModel {
                    TextEditor().environmentObject(text).environmentObject(settings)
                }
            }
        }
    }
}

struct EditorHorizontalMenuView: View {
    
    @EnvironmentObject var settings: EditorSettings
    @Binding var selectedItem: PhotosPickerItem?
    @Binding var currentEditor: EditorView.editigView
    @Binding var topitem: TemplateProtocol?
    @Binding var animate: Bool
    @Binding var animateEditor: Bool
    @Binding var finish: Bool
    
    var editble: TemplateProtocol
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            
            HStack(alignment: .center, spacing: 10) {
                SpacingView(side: .horizontal, size: horPadding-10)
                
                Button {
                    topitem = nil
                    animate = false
                    settings.textFieldViewModels.removeAll()
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "arrow.left.circle.fill")
                            .resizable()
                            .fontWeight(.black)
                            .aspectRatio(contentMode: ContentMode.fit)
                            .frame(height: 20, alignment: .center)
                        Text("L_Back".localized())
                           
                    }.GrayButtonStyle()
                    
                }
                
                if editble.canChooseImage {
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()) {
                            HStack(spacing: 10) {
                                Image(systemName: "photo.on.rectangle.angled")
                                    .resizable()
                                    .fontWeight(.black)
                                    .aspectRatio(contentMode: ContentMode.fit)
                                    .frame(height: 20, alignment: .center)
                                Text("L_SelectPhotoButtonText".localized())
                            }
                            
                        }.BlueButtonStyle()
                        .onChange(of: selectedItem) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    settings.selectedImageData = data
                                }
                            }
                        }
                }
                
                
                
                Button {
                    currentEditor = .colors
                    animateEditor.toggle()
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "paintbrush.fill")
                            .resizable()
                            .fontWeight(.black)
                            .aspectRatio(contentMode: ContentMode.fit)
                            .frame(height: 20, alignment: .center)
                        Text("L_Colors".localized())
                    } .BlueButtonStyle()
                }
                
                Button {
                    currentEditor = .fonts
                    animateEditor.toggle()
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "text.alignleft")
                            .resizable()
                            .fontWeight(.black)
                            .aspectRatio(contentMode: ContentMode.fit)
                            .frame(height: 15, alignment: .center)
                        Text("L_Fonts".localized())
                    }
                    .BlueButtonStyle()
                    
                }
                
                
                Button {
                    finish = true
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "photo.fill.on.rectangle.fill")
                            .resizable()
                            .fontWeight(.black)
                            .aspectRatio(contentMode: ContentMode.fit)
                            .frame(height: 20, alignment: .center)
                        Text("Preview")
                    }
                }.GreenButtonStyle()
                
              
                SpacingView(side: .horizontal, size: 25)
            }
        }.onAppear {
            AnalyticsWrapper.onScreanAppear("Editor")
        }

    }
    
}

class TextFieldViewModel: ObservableObject {
    @Published var text: String
    init(text: String) {
        self.text = text
    }
}

class EditorSettings: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var imageBG : Color = .white
    
    @Published var imageOffset: CGPoint = CGPoint(x: 0, y: 0)
    @Published var imagescale : Double = 2.0
    @Published var selectedImageData: Data = Data()
    @Published var uiimage: UIImage = UIImage(named: "placeholder")!
    
    //NEW
    @Published var textFieldViewModels: [TextFieldViewModel] = []
    @Published var correnTextFieldViewModel: TextFieldViewModel?
    // OLD
    @Published var toptext: String = "L_DefTemplateTitleText".localized()
    @Published var middletext: String = "L_DefTemplateArticleText".localized()
    
    @Published var fonts: FontPalette = FontPalettes.first!
    @Published var colors: ColorPalette = ColorPalettes.first!
    
    @Published var textEditingMode: Bool = false

    
    init(){
        $selectedImageData.sink { val in
            self.uiimage = UIImage(data: val) ?? UIImage(named: "placeholder")!
            self.objectWillChange.send()
        }.store(in: &subscriptions)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    @State static var item: TemplateProtocol? = MenuWithImageTemplate()
    @Namespace static var namespace

    static var previews: some View {
        //        NavigationStack {
        //            //SubscriptionView()
        //            //HomeView().navigationTitle("Winst")
        //            ContentView(template: MenuWithImageTemplate())
        //        }.preferredColorScheme(.light)
        NavigationStack {
            //SubscriptionView()
            //HomeView().navigationTitle("Winst")
            HomeView()
                .environmentObject(EditorSettings())
             //   .navigationTitle("Winst")
//            EditorView(animate: .constant(true), finish: .constant(false),
//                       topitem: ContentView_Previews.$item,
//                       template: ContentView_Previews.item!,
//                       namespace: ContentView_Previews.namespace)
        }.preferredColorScheme(.light)
        //        NavigationStack {
        //            //SubscriptionView()
        //            //HomeView().navigationTitle("Winst")
        //            ContentView(template: TextBlockView())
        //        }.preferredColorScheme(.light)
    }
}
