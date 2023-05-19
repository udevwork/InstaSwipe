//
//  ImagesToSavePreviewView.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 11.04.2023.
//

import SwiftUI
import AlertToast
import SwiftRater

struct ImagesToSavePreviewView: View {
    
    @State var images: [UIImage] = []
    var width = UIScreen.main.bounds.width / 1.8
    @EnvironmentObject var settings: EditorSettings

    @State private var showToast = false
    var editble: TemplateProtocol
    
    @Binding var finish: Bool
    var namespace: Namespace.ID
    
    init(editble: TemplateProtocol, finish: Binding<Bool>, namespace: Namespace.ID) {
        self.editble = editble
        _finish = finish
        self.namespace = namespace
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Spacer()
           
            HStack(spacing: 16) {
                EmodjiIcon(iconText: "🥳").lightShadow()
                VStack(alignment: .leading, spacing: 1) {
                    SectionTitleView(text: "L_Almost_there".localized(), alignment: .leading)
                    ArticleView(text: editble.aspectRatio.getDescription(), alignment: .leading)
                }
            }.frame(width: width)
            
            
            
         
                  
                VStack(alignment: .center, spacing: 0) {
                    
                    Image(editble.aspectRatio.getPreviewImageNames().0)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    if editble.aspectRatio == .high {
                        Image(uiImage: images.first ?? UIImage())
                            .resizable()
                           
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                            
                            .aspectRatio(editble.aspectRatio.getAspectRatioForPreview(), contentMode: .fit)
                            .matchedGeometryEffect(id: editble.blockNameInMenu, in: namespace, properties: .frame)
                            .background {
                                Color.black
                            }
                    } else {
                        TabView {
                            ForEach(images, id: \.self) { img in
                                Image(uiImage: img)
                                    .resizable()
                            }
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .matchedGeometryEffect(id: editble.blockNameInMenu, in: namespace, properties: .frame)
                        .aspectRatio(editble.aspectRatio.getAspectRatioForPreview(), contentMode: .fit)
                    }
                    Image(editble.aspectRatio.getPreviewImageNames().1)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    
                }.frame(width: width, alignment: .center)
                    .background {
                        Color.lightGray
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 21, style: .continuous))
                    .lightShadow()
            
            
            
            HStack {
                Button {
                    finish = false
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "arrow.left.circle.fill")
                            .resizable()
                            .fontWeight(.black)
                            .aspectRatio(contentMode: ContentMode.fit)
                            .frame(height: 20, alignment: .center)
                        Text("L_Back")
                    }
                }.GrayButtonStyle()
                
                Button {
                    saveImagesToPhotos()
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "square.and.arrow.down")
                            .resizable()
                            .fontWeight(.black)
                            .aspectRatio(contentMode: ContentMode.fit)
                            .frame(height: 20, alignment: .center)
                        Text("L_SaveImagesToPhotosButtonText".localized())
                    }
                }.BlueButtonStyle()
            }
            
            Spacer()
        }.frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .navigationBarHidden(true)
        //.background(BGColor)
        .background {
            Image("LounchScreenBG").resizable().aspectRatio(contentMode: .fill).opacity(0.2)
        }
        .background(BGColor)
        .toast(isPresenting: $showToast) {
            AlertToast(type: .complete(.green), title: "L_SuccessSavigAlertText".localized())
        }
        .onAppear{
            self.images = editble.generateUIImage(settings: settings)
            AnalyticsWrapper.onScreanAppear("Preview")
        }
        
    }
    
    
    func saveImagesToPhotos() {
        images.forEach { img in
            UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
        }
        showToast.toggle()
        
        SwiftRater.incrementSignificantUsageCount()
        SwiftRater.check()
        AnalyticsWrapper.onPhotoSave()
    }
}

//struct ImagesToSavePreviewView_Previews: PreviewProvider {
//
//    //@StateObject static var settings = EditorSettings()
//    @Namespace static private var namespace
//
//    static var previews: some View {
//        ImagesToSavePreviewView(editble: (SquareTextView().environmentObject(EditorSettings())) as! TemplateProtocol, finish: .constant(true), namespace: namespace).environmentObject(EditorSettings())
//    }
//
//}


