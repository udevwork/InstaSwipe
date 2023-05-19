//
//  MenuWithImageTemplate.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 11.03.2023.
//

import SwiftUI

struct MenuWithImageTemplate: View, TemplateProtocol, Identifiable {
    var avalableOnlyInPro: Bool = true
    var blockIconImageName: String = "menu image"
    var destinationSize: CGSize = .init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/2)
    var aspectRatio: TemplateAspectType = .wide
    var id = UUID().uuidString
    var blockNameInMenu: String = "L_TextWithImageMenuItemName".localized()
    var blockDescription: String = "L_TextWithImageDescription".localized()
    let canChooseImage: Bool = true
    
    @EnvironmentObject var settings: EditorSettings
    
    var imageBlock = RightImageView()
    var textBlock = SquareTextView()
    
    var body: some View {
        
        HStack(spacing: 0) {
            textBlock
                .environmentObject(settings)
                .aspectRatio(1/1.1, contentMode: .fit)
            imageBlock
                .environmentObject(settings)
              
        }
        
    }
    
    func generateUIImage(settings: EditorSettings) -> [UIImage] {
        var result = [UIImage]()
        result.reserveCapacity(2)
        
        let content = self.environmentObject(settings)
        let renderer = ImageRenderer(content: content)
        renderer.proposedSize = .init(width: destinationSize.width, height: destinationSize.height)
        renderer.scale = 10
        
        guard let uiimage = renderer.uiImage else { return result }
        
        for direction in [CroppPart.left, CroppPart.right] {
            if let image = uiimage.cropsToSquare(direction) {
                result.append(image)
            }
        }
        
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
