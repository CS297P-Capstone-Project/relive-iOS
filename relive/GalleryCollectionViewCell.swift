//
//  GalleryCollectionViewCell.swift
//  relive
//
//  Created by Tanya Lohiya on 5/27/22.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    static let identifier = "GalleryCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        
//        let images = [UIImage(named:"oops1"),
//                      UIImage(named:"oops2"),
//                      UIImage(named:"oops3"),
//                      UIImage(named:"oops1"),
//                      UIImage(named:"oops2"),
//                      UIImage(named:"oops3"),
//        ].compactMap({ $0 })
//        imageView.image = images.randomElement()
    }
    
    func configure(with image :UIImage){
        imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
