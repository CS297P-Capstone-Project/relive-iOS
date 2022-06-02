//
//  Feature.swift
//  relive
//
//  Created by Tanya Lohiya on 5/31/22.
//

import Foundation
import UIKit

struct Feature {
    private(set) public var imageName :String
    private(set) public var title :String
    private(set) public var id :String
    private(set) public var frameColor :UIColor
    
    init(imageName :String, title :String, id :String, frameColor: UIColor){
        self.imageName = imageName
        self.title = title
        self.id = id
        self.frameColor = frameColor
    }
}
