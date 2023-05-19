//
//  blackfilter.metal
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 23.02.2023.
//

#include <metal_stdlib>
#include <CoreImage/CoreImage.h>
using namespace metal;

extern "C" {
  namespace coreimage {
      float4 grayscaleFilterKernel(sample_t s) {
        float gray = (s.r + s.g + s.b) / 3;
        return float4(gray, gray, gray, s.a);
      }
  }
}
