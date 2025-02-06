//
//  ImageProcessor.swift
//  PhotoEditor
//
//  Created by Denis Haritonenko on 3.02.25.
//

import Foundation
import UIKit

class ImageProcessor {
  static let shared = ImageProcessor()
  var output = UIImage()
  let context = CIContext()
  
  private func renderAsUIImage(_ image: CIImage) -> UIImage? {
    if let cgImage = context.createCGImage(image, from: image.extent) {
      return UIImage(cgImage: cgImage)
    }
    return nil
  }
  
  private func applyColorKernel(input: CIImage) {
    let filter = ColorFilter()
    filter.inputImage = input
    if let outputImage = filter.outputImage,
      let renderImage = renderAsUIImage(outputImage) {
      output = renderImage
    }
  }

  
  func process(painting: String) {
    guard
      let paintImage = UIImage(named: painting),
      let input = CIImage(image: paintImage)
    else {
      print("Invalid input image")
      return
    }
      
    applyColorKernel(input: input)
  }
}

