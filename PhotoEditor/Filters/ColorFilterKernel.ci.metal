//
//  ColorFilterKernel.ci.metal
//  PhotoEditor
//
//  Created by Denis Haritonenko on 3.02.25.
//

#include <CoreImage/CoreImage.h>
 
extern "C" {
  namespace coreimage {
    float4 colorFilterKernel(sample_t s) {
        
        float gray = (s.r + s.g + s.b) / 3;
        return float4(gray, gray, gray, s.a);
    }
  }
}
