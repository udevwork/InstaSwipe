//
//  ImageCropper.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 08.03.2023.
//

import Foundation
import UIKit

class ImageCropper {
    func crop() {
        
        
    }
}

enum CroppPart {
    case left,right
}

extension UIImage {
    func cropsToSquare(_ part: CroppPart) -> UIImage? {
        if let image = self.cgImage {
            let refWidth = CGFloat((image.width))
            let refHeight = CGFloat((image.height))
            let cropSize = refWidth > refHeight ? refHeight : refWidth
            
            var x:CGFloat = 0
            var y:CGFloat = 0
            
            if part == .left {
                x = 0
                y = 0
            }
            
            if part == .right {
                 x = (refWidth - cropSize) /// 2.0
                 y = (refHeight - cropSize) /// 2.0
            }
            
            let cropRect = CGRect(x: x, y: y, width: cropSize, height: cropSize)
            let imageRef = image.cropping(to: cropRect)
            let cropped = UIImage(cgImage: imageRef!, scale: 0.0, orientation: self.imageOrientation)
            return cropped
        }
        return nil
    }
}
