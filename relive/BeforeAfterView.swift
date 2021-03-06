//
//  BeforeAfterView.swift
//  BeforeAfterTest
//
//  Created by Anant Sharma on 6/2/22.
//

import UIKit
import Foundation

public class BeforeAfterView: UIView {
    
    fileprivate var leading: NSLayoutConstraint!
    fileprivate var originRect: CGRect!
    
    var image1: UIImage = UIImage()
    
    var image2: UIImage = UIImage()
    
    public func setData(image1: UIImage, image2: UIImage, thumbColor: UIColor) {
        imageView1.image = image1
        imageView2.image = image2
        //thumb.backgroundColor = thumbColor
        
//        thumb.backgroundColor = .black
        let imageName = "arrow.left.arrow.right.circle.fill"
        let image = UIImage(systemName: imageName)
//        let imageView = UIImageView(image: image!)
//        imageView.frame = CGRect(x: thumb.frame.height, y: thumb.frame.width, width: 40, height: 40)
//        imageView.tintColor = .red
//        //imageView.backgroundColor = .black
//        thumb.addSubview(imageView)
        thumb.image = image
        thumb.tintColor = .red
        
    }
    public var thumbColor: UIColor = UIColor.white

    fileprivate lazy var imageView2: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    fileprivate lazy var imageView1: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    fileprivate lazy var image1Wrapper: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.clipsToBounds = true
        return v
    }()
    
    fileprivate lazy var thumbWrapper: UIView = {
        let v = UIView()
        
//        let imageName = "image1.png"
//        let image = UIImage(named: imageName)
//        let imageView = UIImageView(image: image!)
//        imageView.frame = CGRect(x: v.frame.height/2, y: v.frame.width/2, width: 20, height: 20)
//        v.addSubview(imageView)
        
        
        v.translatesAutoresizingMaskIntoConstraints = false
        v.clipsToBounds = true
        return v
    }()
    
    fileprivate lazy var thumb: UIImageView = {
        let v = UIImageView()
        //v.backgroundColor = UIColor.black
        
        v.translatesAutoresizingMaskIntoConstraints = false
        v.clipsToBounds = true
        return v
    }()
    
    lazy fileprivate var setupLeadingAndOriginRect: Void = {
        self.leading.constant = self.frame.width / 2
        self.layoutIfNeeded()
        self.originRect = self.image1Wrapper.frame
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        _ = setupLeadingAndOriginRect
    }
}

extension BeforeAfterView {
    fileprivate func initialize() {
        
        imageView1.image = image1
        imageView2.image = image2
//        thumb.backgroundColor = thumbColor
        
        image1Wrapper.addSubview(imageView1)
        addSubview(imageView2)
        addSubview(image1Wrapper)
        
        thumbWrapper.addSubview(thumb)
        addSubview(thumbWrapper)
        
        NSLayoutConstraint.activate([
            imageView2.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imageView2.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            imageView2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            imageView2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        ])
        
        leading = image1Wrapper.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        
        NSLayoutConstraint.activate([
            image1Wrapper.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            image1Wrapper.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            image1Wrapper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            leading
        ])
        
        NSLayoutConstraint.activate([
            imageView1.topAnchor.constraint(equalTo: image1Wrapper.topAnchor, constant: 0),
            imageView1.bottomAnchor.constraint(equalTo: image1Wrapper.bottomAnchor, constant: 0),
            imageView1.trailingAnchor.constraint(equalTo: image1Wrapper.trailingAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            thumbWrapper.topAnchor.constraint(equalTo: image1Wrapper.topAnchor, constant: 0),
            thumbWrapper.bottomAnchor.constraint(equalTo: image1Wrapper.bottomAnchor, constant: 0),
            thumbWrapper.leadingAnchor.constraint(equalTo: image1Wrapper.leadingAnchor, constant: -20),
            thumbWrapper.widthAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            thumb.centerXAnchor.constraint(equalTo: thumbWrapper.centerXAnchor, constant: 0),
            thumb.centerYAnchor.constraint(equalTo: thumbWrapper.centerYAnchor, constant: 0),
            thumb.widthAnchor.constraint(equalTo: thumbWrapper.widthAnchor, multiplier: 1),
            thumb.heightAnchor.constraint(equalTo: thumbWrapper.widthAnchor, multiplier: 1)
        ])
        
        leading.constant = frame.width / 2
        
//        thumb.layer.cornerRadius = 20
        imageView1.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        let tap = UIPanGestureRecognizer(target: self, action: #selector(gesture(sender:)))
        thumbWrapper.isUserInteractionEnabled = true
        thumbWrapper.addGestureRecognizer(tap)
    }
    
    
    @objc func gesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        switch sender.state {
        case .began, .changed:
            var newLeading = originRect.origin.x + translation.x
            newLeading = max(newLeading, 20)
            newLeading = min(frame.width - 20, newLeading)
            leading.constant = newLeading
            layoutIfNeeded()
        case .ended, .cancelled:
            originRect = image1Wrapper.frame
        default: break
        }
    }
}





