//
//  SnapPanGestureRecognizer.swift
//  PhotoEditor
//
//  Created by Denis Haritonenko on 11.02.25.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

enum snapPanGestureRecognizerDirection {
    case snapPanGestureRecognizerDirectionVertical
    case snapPanGestureRecognizerDirectionHorizontal
}

class SnapPanGestureRecognizer: UIPanGestureRecognizer {
    
    var direction: snapPanGestureRecognizerDirection = .snapPanGestureRecognizerDirectionHorizontal
    var moveX: CGFloat = 0.0
    var moveY: CGFloat = 0.0
    var drag: Bool = false
    
    static let kDirectionPanThreshold: Float = 5.0
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        
        if state == .failed { return }
        let nowPoint = touches.first?.location(in: self.view)
        let prePoint = touches.first?.previousLocation(in: self.view)
        
        moveX += (prePoint?.x)! - (nowPoint?.x)!
        moveY += (prePoint?.y)! - (nowPoint?.y)!
        
        if !drag {
            if fabsf(Float(moveX)) > SnapPanGestureRecognizer.kDirectionPanThreshold {
                if direction == .snapPanGestureRecognizerDirectionVertical {
                    self.state = .failed
                } else {
                    drag = true
                }
            } else if fabsf(Float(moveY)) > SnapPanGestureRecognizer.kDirectionPanThreshold {
                if direction == .snapPanGestureRecognizerDirectionHorizontal {
                    self.state = .failed
                } else {
                    drag = true
                }
            }
        }
    }
    
    
    override func reset() {
        super.reset()
        drag = false
        moveX = 0
        moveY = 0
    }
}
