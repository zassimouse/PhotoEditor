//
//  ViewController.swift
//  PhotoEditor
//
//  Created by Denis Haritonenko on 11.02.25.
//

import UIKit

class ViewController: UIViewController {
    
    var panGes: SnapPanGestureRecognizer!
    var topSlider: SnapTopSlider?
    var values:Array<Double>?
    var preTranslate = CGPoint(x: 0, y: 0)
    var selectedIndex: Int? = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        
        values = Array.init(arrayLiteral: 0,0,0,0,0,0,0)

        
        let v = UIView(frame: CGRect(x: 0, y: 200, width: self.view.frame.width, height: 500))
        v.backgroundColor = .green
        view.addSubview(v)
        
        panGes = SnapPanGestureRecognizer(target: self, action: #selector(changeValue(sender:)))
        panGes.direction = .snapPanGestureRecognizerDirectionHorizontal
        v.addGestureRecognizer(panGes)

        topSlider = SnapTopSlider.init(name: "hi", value: 0)
        topSlider?.backgroundColor = UIColor.clear
        topSlider?.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: 11)
        self.view.addSubview(topSlider!)
    }
    
    @objc func changeValue(sender: UIPanGestureRecognizer) {

        print("pan recognizer working")
        let translate = sender.translation(in: self.view)
        
        let x = Double(suitableValue(point: translate).x - preTranslate.x)
        
        values?[selectedIndex!] += x
        
        topSlider?.update(name: "hi", value: (values?[selectedIndex!])!)
        
        preTranslate = suitableValue(point: translate)
        
        if sender.state == .ended {
            preTranslate = CGPoint(x: 0, y: 0)
            topSlider?.coverHidden()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(self.view.gestureRecognizers ?? "No gesture recognizers")
    }
    
    func suitableValue(point: CGPoint) -> CGPoint {
        var suitablePoint = point
        suitablePoint.x = (point.x / 3)
        return suitablePoint
    }
}
