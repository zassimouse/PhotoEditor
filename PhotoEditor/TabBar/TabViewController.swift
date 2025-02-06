//
//  ViewController.swift
//  PhotoEditor
//
//  Created by Denis Haritonenko on 5.02.25.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabItems()
    }
    
    private func setupTabItems() {
        tabBar.tintColor = .label
        tabBar.backgroundColor = .red
        let vc1 = ViewController()
        let vc2 = ViewController()
        let vc3 = ViewController()
        
        vc1.tabBarItem.image = UIImage(named: "house-alt")
        vc2.tabBarItem.image = UIImage(named: "plus-box")
        vc3.tabBarItem.image = UIImage(named: "folder")

        setViewControllers([vc1, vc2, vc3], animated: true)
    }
}
