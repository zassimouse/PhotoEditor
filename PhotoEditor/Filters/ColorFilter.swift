//
//  ColorFilters.swift
//  PhotoEditor
//
//  Created by Denis Haritonenko on 3.02.25.
//

import Foundation
import CoreImage

class ColorFilter: CIFilter {
    
  var inputImage: CIImage?

  static var kernel: CIKernel = { () -> CIColorKernel in
    guard let url = Bundle.main.url(
      forResource: "ColorFilterKernel.ci",
      withExtension: "metallib"),
      let data = try? Data(contentsOf: url) else {
      fatalError("Unable to load metallib")
    }

    guard let kernel = try? CIColorKernel(
      functionName: "colorFilterKernel",
      fromMetalLibraryData: data) else {
      fatalError("Unable to create color kernel")
    }

    return kernel
  }()

  override var outputImage: CIImage? {
    guard let inputImage = inputImage else { return nil }
    return ColorFilter.kernel.apply(
      extent: inputImage.extent,
      roiCallback: { _, rect in
        return rect
      },
      arguments: [inputImage])
  }
}
