//
//  ZoomableViewController.swift
//  relive
//
//  Created by Tanya Lohiya on 6/9/22.
//

import UIKit

class ZoomableViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    var imageUrl:URL = URL(fileURLWithPath: "")
    
    @IBOutlet weak var shareBtn: UIImageView!
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(contentsOfFile: imageUrl.path)
        
        imageView.isUserInteractionEnabled = true
        
//        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchGesture))
//        pinchGesture.
//        imageView.addGestureRecognizer(pinchGesture)
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        
        
        self.cancelBtn.imageView?.contentMode = .scaleAspectFit
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    @IBAction func shareBtnPressed(_ sender: Any) {
        let image = self.imageView.image

        // set up activity view controller
        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func pinchGesture(sender:UIPinchGestureRecognizer) {
        sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
        sender.scale = 1.0
    }

}
