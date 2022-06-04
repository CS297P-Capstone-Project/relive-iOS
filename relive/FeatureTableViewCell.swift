//
//  FeatureTableViewCell.swift
//  relive
//
//  Created by Tanya Lohiya on 5/31/22.
//

import UIKit

class FeatureTableViewCell: UITableViewCell {

    @IBOutlet weak var beforeAfterView: BeforeAfterView!
    
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
        let image1 = UIImage(named: feature.oldImageName) ?? UIImage()
        let image2 = UIImage(named: feature.newImageName) ?? UIImage()
        
        beforeAfterView.setData(image1: image1, image2: image2, thumbColor: .red)
        
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


