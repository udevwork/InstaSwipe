//
//  TemplateProtocol.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 10.03.2023.
//

import Foundation
import UIKit

enum TemplateAspectType {
    case square, rectangle, high, wide
    func getAspectRatio() -> CGFloat {
        switch self {
            case .square:
                return (1/1)
            case .rectangle:
                return (4/3)
            case .high:
                return (9/16)
            case .wide:
                return (2/1)
        }
    }
    
    func getAspectRatioForPreview() -> CGFloat {
        switch self {
            case .square:
                return (1/1)
            case .rectangle:
                return (1/1.2)
            case .high:
                return (9/16)
            case .wide:
                return (1/1)
        }
    }
    
    func getPreviewImageNames() -> (String, String) {
        switch self {
            case .square:
                return ("Feed Post - top","Feed Post - bottom")
            case .rectangle:
                return ("Feed Post - top","Feed Post - bottom")
            case .high:
                return ("Story - top","Story - bottom")
            case .wide:
                return ("Feed Post - top","Feed Post - bottom")
        }
    }
    
    func getDescription() -> String {
        switch self {
            case .square:
                return "L_square_Description".localized()
            case .rectangle:
                return "L_rectangle_Description".localized()
            case .high:
                return "L_high_Description".localized()
            case .wide:
                return "L_wide_Description".localized()
        }
    }
    
}

protocol TemplateProtocol {
    var canChooseImage: Bool { get }
    
    var blockDescription: String { get }
    var blockNameInMenu: String { get }
    var blockIconImageName: String { get }
    var avalableOnlyInPro: Bool { get }
    
    var aspectRatio: TemplateAspectType { get }
    var destinationSize: CGSize { get }
    
    func saveImage(settings: EditorSettings)
    func generateUIImage(settings: EditorSettings) -> [UIImage]
    func saveImagesToPhotos(images: [UIImage])
}
