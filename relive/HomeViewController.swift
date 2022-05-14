//
//  HomeViewController.swift
//  relive
//
//  Created by Tanya Lohiya on 5/13/22.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func EnhanceImageBtnPressed(_ sender: Any) {
        showMiracle()
    }
    
    
    @objc func showMiracle() {
            let slideVC = OverlayView()
            slideVC.modalPresentationStyle = .custom
            slideVC.transitioningDelegate = self
            self.present(slideVC, animated: true, completion: nil)
        }
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
