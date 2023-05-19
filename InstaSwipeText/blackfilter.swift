//
//  blackfilter.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 19.03.2023.
//

import Foundation
import CoreImage

class GrayscaleFilter: CIFilter {
    
       
    func process(inputImage: CIImage?) -> CIImage? {
        guard let inputImage = inputImage else { return nil }
        let res = GrayscaleFilter.kernel.apply(extent: inputImage.extent, roiCallback: { (index, rect) -> CGRect in
            return rect
        }, arguments: [inputImage])
        return res
    }
    
    static var kernel: CIColorKernel = { () -> CIColorKernel in
        let url = Bundle.main.url(forResource: "default",
                                  withExtension: "metallib")! //1
        let data = try! Data(contentsOf: url)
        return try! CIColorKernel(functionName: "grayscaleFilterKernel",
                                  fromMetalLibraryData: data) //2
    }()
    
}
