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
        Feature(imageName: "colorize1", title: "Colorize Image", id: "COLORIZE",frameColor:.black),
        Feature(imageName: "enhance1", title: "Enhance Image", id: "ENHANCE",frameColor:.black),
        Feature(imageName: "unscratch1", title: "Unscratch Image", id: "UNSCRATCH",frameColor:.black)
    ]
    
    func getFeatures() -> [Feature] {
        return features
    }
}
