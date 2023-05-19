//
//  ImageWithMenuTemplate.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 10.03.2023.
//

import SwiftUI

struct RightImageView: View {
    
    var size : CGFloat = UIScreen.main.bounds.width/4
    
    @State private var lastScaleValue = 1.0
    @State private var lastX = 0.0
    @State private var lastY = 0.0
    @EnvironmentObject var settings: EditorSettings
    
    private var img: UIImage? = nil
    
    var body: some View {
        GeometryReader { reader in
            Image(uiImage: settings.uiimage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: reader.size.width * settings.imagescale,
                       height: reader.size.height * settings.imagescale)
                .position(x: reader.frame(in: .local).midX + settings.imageOffset.x,
                          y: reader.frame(in: .local).midY + settings.imageOffset.y)
                .gesture(simpleDrag.exclusively(before: simpleZoom))
                .mask { Rectangle() }
        }
    }
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                let newX = (lastX + value.translation.width)/2
                let newY = (lastY + value.translation.height)/2
                
                settings.imageOffset = CGPoint(x: newX, y: newY)
                print(settings.imageOffset)
            }.onEnded { value in
                lastX = lastX + value.translation.width
                lastY = lastY + value.translation.height
            }
    }
    
    var simpleZoom: some Gesture {
        MagnificationGesture()
            .onChanged { amount in
                let delta = amount / self.lastScaleValue
                self.lastScaleValue = amount
                let newScale = settings.imagescale * delta
                settings.imagescale = newScale
                print(settings.imagescale)
            }
            .onEnded { amount in
                self.lastScaleValue = 1.0
            }
    }
}

struct ImageWithMenuTemplate: View, TemplateProtocol, Identifiable {
    
    var blockIconImageName: String = "image menu"
    var avalableOnlyInPro: Bool = false
    
    var id = UUID().uuidString
    var destinationSize: CGSize = .init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/2)
    var aspectRatio: TemplateAspectType = .wide
    var blockNameInMenu: String = "L_ImageWithTextMenuItemName".localized()
    var blockDescription: String = "L_ImageWithTextDescription".localized()
    let canChooseImage: Bool = true
    
    @EnvironmentObject var settings: EditorSettings
    
    var imageBlock = RightImageView()
    var textBlock = SquareTextView()
    
    var body: some View {
        HStack(spacing: 0) {
            imageBlock
                .environmentObject(settings)
                
            textBlock
                .environmentObject(settings)
                .aspectRatio(1/1.1, contentMode: .fit)
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

