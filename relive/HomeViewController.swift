//
//  HomeViewController.swift
//  relive
//
//  Created by Tanya Lohiya on 5/13/22.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var featureTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        featureTable.dataSource = self
        featureTable.delegate = self
        self.featureTable.rowHeight = 400

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showMiracle(operation: FeatureDataFile.instance.getFeatures()[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FeatureDataFile.instance.getFeatures().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FeatureTableViewCell.identifier) as? FeatureTableViewCell {
            let feature = FeatureDataFile.instance.getFeatures()[indexPath.row]
            cell.updateViews(feature: feature)
            return cell
        } else {
            return FeatureTableViewCell()
        }
    }
    
    @objc func showMiracle(operation :String) {
            
            let slideVC = OverlayView()
            slideVC.modalPresentationStyle = .custom
            slideVC.transitioningDelegate = self
            slideVC.operation = operation
            self.present(slideVC, animated: true, completion: nil)
    }
    
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

