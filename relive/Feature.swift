//
//  Feature.swift
//  relive
//
//  Created by Tanya Lohiya on 5/31/22.
//

import Foundation
import UIKit

struct Feature {
    private(set) public var oldImageName :String
    private(set) public var newImageName :String
    private(set) public var title :String
    private(set) public var id :String
    private(set) public var frameColor :UIColor
    
    init(oldImageName :String, newImageName: String, title :String, id :String, frameColor: UIColor){
        self.oldImageName = oldImageName
        self.newImageName = newImageName
        self.title = title
        self.id = id
        self.frameColor = frameColor
    }
}
