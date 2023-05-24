//
//  SquareTemplate.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 10.03.2023.
//

import Foundation
import SwiftUI


struct TextBlockView: View, TemplateProtocol, Identifiable {
    var avalableOnlyInPro: Bool = false
    var blockIconImageName: String = "square"
    var id = UUID().uuidString
    var destinationSize: CGSize = .init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
    var aspectRatio: TemplateAspectType = .square
    var blockNameInMenu: String = "L_SquareWithTextTemplateMenuItemName".localized()
    var blockDescription: String = "L_SquareWithTextTemplateDescription".localized()
    let canChooseImage: Bool = false
    
    @EnvironmentObject var settings: EditorSettings
    
    var textBlock = SquareTextView()
    
    var body: some View {
        textBlock
            .environmentObject(settings)
            .aspectRatio(aspectRatio.getAspectRatio(), contentMode: .fill)
    }
    
    func generateUIImage(settings: EditorSettings) -> [UIImage] {
        
        var result: [UIImage] = []
        
        let content = self.frame(width: destinationSize.width,
                                 height: destinationSize.height,
                                 alignment: .center)
            .environmentObject(settings)
        let renderer = ImageRenderer(content: content)
        renderer.scale = 10
        
        guard let uiimage = renderer.uiImage else { return result }
        
        result.append(uiimage)
        return result
    }
    
    func saveImagesToPhotos(images: [UIImage]) {
        images.forEach { img in
            UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
        }
    }
    
    func saveImage(settings: EditorSettings) {
        let images = self.generateUIImage(settings: settings)
        saveImagesToPhotos(images: images)
    }
}

struct SquareTextView: View {
    
    @EnvironmentObject var settings: EditorSettings
    var useAdditionalOffest: Bool = false
    
    func appendTextModels() {
        settings.textFieldViewModels
            .append(TextFieldViewModel(text: "L_DefTemplateTitleText".localized()))
        settings.textFieldViewModels
            .append(TextFieldViewModel(text: "L_SquareWithTextTemplateDescription".localized()))
    }
    

    
    var body: some View {
        
        HStack(alignment: .center) {
            
            GeometryReader { reader in
                
                VStack(alignment:.leading, spacing: reader.size.width  * (1/13)) {
                    
                    if settings.textFieldViewModels.count > 0 {
                        Text(settings.textFieldViewModels[0].text)
                            .font(.system(size: reader.size.width  * (1/12), weight: settings.fonts.titleFontWeight, design: settings.fonts.titleFontDesign))
                            .foregroundColor(settings.colors.mainColor)
                            .multilineTextAlignment(.leading)
                            .onTapGesture {
                                settings.correnTextFieldViewModel = settings.textFieldViewModels[0]
                                settings.textEditingMode = true
                            }
                    }
                    
                    if settings.textFieldViewModels.count > 1 {
                        Text(settings.textFieldViewModels[1].text)
                            .font(.system(size: reader.size.width  * (1/20), weight: settings.fonts.articleFontWeight, design: settings.fonts.articleFontDesign))
                            .foregroundColor(settings.colors.secondaryColor)
                            .multilineTextAlignment(.leading)
                            .onTapGesture {
                                settings.correnTextFieldViewModel = settings.textFieldViewModels[1]
                                settings.textEditingMode = true
                            }
                    }
                    
                    Spacer()
                    if User.shared.isProUser == false {
                        TextLogoView(size: reader.size.width  * (1/20)).environmentObject(settings)
                    }
                    
                }.padding(.horizontal, reader.size.width  * (1/6))
                    .padding(.vertical, reader.size.width  * (1/7))
                    .offset(x: useAdditionalOffest ? reader.size.width  * (1/15) : 0)
            }.background(settings.colors.backgroundColor)
        }.onAppear{
            self.appendTextModels()
        }
    }
}
