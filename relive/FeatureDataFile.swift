//
//  FeatureDataFile.swift
//  relive
//
//  Created by Tanya Lohiya on 5/31/22.
//

import Foundation
class FeatureDataFile {
    static let instance = FeatureDataFile()
    
    private let features = [
        Feature(oldImageName: "ColorNew",newImageName: "ColorOld", title: "Colorize Image", id: "COLORIZE",frameColor:.black),
        Feature(oldImageName: "enhanceNew",newImageName: "enhanceOld", title: "Enhance Image", id: "ENHANCE",frameColor:.black),
        Feature(oldImageName: "ScratchNew",newImageName: "ScratchOld", title: "Unscratch Image", id: "UNSCRATCH",frameColor:.black)
    ]
    
    func getFeatures() -> [Feature] {
        return features
    }
}
