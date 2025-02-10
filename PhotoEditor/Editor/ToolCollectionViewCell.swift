//
//  ToolCollectionViewCell.swift
//  PhotoEditor
//
//  Created by Denis Haritonenko on 10.02.25.
//

import UIKit

class ToolCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(label)
    }
    
    let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        let image = UIImage(named: "sun")?.withTintColor(.label)
        imageView.image = image
        imageView.frame = CGRect(x: 0, y: 10, width: 70, height: 40)
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 10)
        label.textAlignment = .center
        label.text = "Brightness"
        label.frame = CGRect(x: 0, y: 50, width: 70, height: 20)
        return label
    }()
    
    func configure(with: String) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


