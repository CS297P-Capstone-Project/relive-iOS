//
//  GalleryCollectionViewCell.swift
//  relive
//
//  Created by Tanya Lohiya on 5/27/22.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    static let identifier = "GalleryCollectionViewCell"
    
    @IBOutlet weak var imageView: UIImageView!
    //    private let imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        return imageView
//    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        contentView.addSubview(imageView)
//
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(GalleryCollectionViewCell.imageTapped(gesture:)))
//
//        // add it to the image view;
//        imageView.addGestureRecognizer(tapGesture)
//        // make sure imageView can be interacted with by user
//        imageView.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
//        fatalError("init(coder:) has not been implemented")
    }
    
//    @objc func imageTapped(gesture: UIGestureRecognizer) {
//        // if the tapped view is a UIImageView then set it to imageview
//        if (gesture.view as? UIImageView) != nil {
////            let storyboard = UIStoryboard(name: "Main", bundle: nil);
////            let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController")
////            vc.modalPresentationStyle = .fullScreen
////            vc.modalTransitionStyle = .flipHorizontal
////            self.present(vc, animated: true, completion: nil);
//        }
//    }
//
    
    func configure(with image :UIImage){
        imageView.image = image
    }
    
//    required init?(coder: NSCoder) {
//        fatalError()
//    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        imageView.frame = contentView.bounds
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
