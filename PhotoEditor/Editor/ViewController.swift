//
//  ViewController.swift
//  PhotoEditor
//
//  Created by Denis Haritonenko on 3.02.25.
//

import UIKit

class ViewController: UIViewController {
    
    let stackView = UIStackView()
    let tabIcons = ["layers", "sliders", "crop", "save"]
    var selectedTabIndex = 0
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let tools: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
//        ImageProcessor.shared.process(painting: "sample")
        
//        imageView.frame = view.bounds
//        view.addSubview(imageView)
//        imageView.image = ImageProcessor.shared.output
        
        setupStackView()
        setupTabs()
    }

    func setupStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        view.addSubview(tools)
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 44),
            
            tools.bottomAnchor.constraint(equalTo: stackView.topAnchor),
            tools.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tools.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tools.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    func setupTabs() {
        for (index, iconName) in tabIcons.enumerated() {
            let button = UIButton(type: .system)
            let image = UIImage(named: iconName)
            button.setImage(image, for: .normal)
            button.tintColor = index == selectedTabIndex ? .white : .gray
            button.tag = index
            button.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
        }
    }

    @objc func tabTapped(_ sender: UIButton) {
        selectedTabIndex = sender.tag
        for case let button as UIButton in stackView.arrangedSubviews {
            button.tintColor = button.tag == selectedTabIndex ? .white : .gray
        }
        print("Selected tab: \(tabIcons[selectedTabIndex])")
    }
}
