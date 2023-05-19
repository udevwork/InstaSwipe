//
//  StoriesTeplate.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 10.03.2023.
//

import Foundation
import SwiftUI

// MARK: - Stories
struct StoriesTextBlockView: View, TemplateProtocol, Identifiable {
    var avalableOnlyInPro: Bool = true
    
    var blockIconImageName: String = "story"
    var id = UUID().uuidString
    var destinationSize: CGSize = .init(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.width / 9 * 16))
    var aspectRatio: TemplateAspectType = .high
    var blockNameInMenu: String = "L_StoryTextTemplateMenuItemName".localized()
    var blockDescription: String = "L_StoryTextTemplateDescription".localized()
    let canChooseImage: Bool = false
    
    @EnvironmentObject var settings: EditorSettings

    var textBlock = SquareTextView()
    
    var body: some View {
        GeometryReader { reader in
            textBlock.environmentObject(settings)
        }
    }
    
    func generateUIImage(settings: EditorSettings) -> [UIImage] {
        
        var result = [UIImage]()
        result.reserveCapacity(1)
        
        let renderer = ImageRenderer(content:  self.frame(width: destinationSize.width, height: destinationSize.height, alignment: .center).environmentObject(settings))
        renderer.scale = 10
        
        if let image = renderer.uiImage {
            result.append(image)
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


