//
//  FeatureTableViewCell.swift
//  relive
//
//  Created by Tanya Lohiya on 5/31/22.
//

import UIKit

class FeatureTableViewCell: UITableViewCell {

    @IBOutlet weak var featureImage: UIImageView!
    @IBOutlet weak var featureTitle: UILabel!
    
    @IBOutlet weak var featureBtn: UIButton!
    
    @IBOutlet weak var featureBackgroundImageView: UIImageView!
    var featureID : String = "ENHANCE"
    
    static let identifier = "FeatureTableViewCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews(feature : Feature){
        featureImage.image = UIImage(named: feature.imageName)
        featureTitle.text = feature.title
        featureID = feature.id
        featureBackgroundImageView.backgroundColor = feature.frameColor
    }

//    @IBAction func EnhanceImageBtnPressed(_ sender: Any) {
    //        showMiracle(operation: "ENHANCE")
    //    }
    //
    //    @IBAction func colorizeImageBtnPressed(_ sender: Any) {
    //        showMiracle(operation: "COLORIZE")
    //    }
        
}


