//
//  ViewController.swift
//  PhotoEditor
//
//  Created by Denis Haritonenko on 3.02.25.
//

import UIKit

class EditorViewController: UIViewController {
    
    let stackView = UIStackView()
    let tabIcons = ["layers", "sliders", "crop", "save"]
    var selectedTabIndex = 0
    var modalView: UIView!
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var toolsCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(ToolCollectionViewCell.self, forCellWithReuseIdentifier: "ToolCell")
        collectionView.backgroundColor = .systemGray6
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        ImageProcessor.shared.process(painting: "sample")
        
//        imageView.frame = view.bounds
//        view.addSubview(imageView)
//        imageView.image = ImageProcessor.shared.output
        
        setupStackView()
        setupTabs()
        setupModalView()
    }

    func setupStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 80),
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
    
    func setupModalView() {
        modalView = UIView()
        
        toolsCollectionView.delegate = self
        toolsCollectionView.dataSource = self
        
        toolsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        modalView.addSubview(toolsCollectionView)


        NSLayoutConstraint.activate([
            toolsCollectionView.topAnchor.constraint(equalTo: modalView.topAnchor),
            toolsCollectionView.leadingAnchor.constraint(equalTo: modalView.leadingAnchor),
            toolsCollectionView.trailingAnchor.constraint(equalTo: modalView.trailingAnchor),
            toolsCollectionView.bottomAnchor.constraint(equalTo: modalView.bottomAnchor)
        ])

        
        
        
        modalView.backgroundColor = .systemBlue
        modalView.layer.cornerRadius = 8
        modalView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        modalView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(modalView, belowSubview: stackView)
        
        
        NSLayoutConstraint.activate([
            modalView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            modalView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            modalView.heightAnchor.constraint(equalToConstant: 80),
            modalView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: 0) // Изначально скрыто
        ])
        
//        modalView.isUserInteractionEnabled = false
        
//        DispatchQueue.main.async {
//            self.toolsCollectionView.collectionViewLayout.invalidateLayout()
//        }

    }

    @objc func tabTapped(_ sender: UIButton) {
        selectedTabIndex = sender.tag
        for case let button as UIButton in stackView.arrangedSubviews {
            button.tintColor = button.tag == selectedTabIndex ? .white : .gray
        }
        
        print("Selected tab: \(tabIcons[selectedTabIndex])")
        
        toggleModal()
    }

    func toggleModal() {
        let isHidden = modalView.frame.origin.y > view.frame.height - stackView.frame.height
        
        UIView.animate(withDuration: 0.3, animations: {
            self.modalView.transform = isHidden ? .identity : CGAffineTransform(translationX: 0, y: 160)
        }) { _ in
            self.modalView.isUserInteractionEnabled = isHidden
        }
    }
}

extension EditorViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToolCell", for: indexPath) as! ToolCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 80, height: 80)
    }
}
