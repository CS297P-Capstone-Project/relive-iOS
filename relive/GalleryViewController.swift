//
//  GalleryViewController.swift
//  relive
//
//  Created by Tanya Lohiya on 5/27/22.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    var images: [UIImage] = []
    var imageNames : [URL] = []
        
//    @IBOutlet weak var emptyGalleryNotifyLabel: UILabel!
    
//    private let collectionView = UICollectionView(
//        frame: .zero,
//        collectionViewLayout: UICollectionViewFlowLayout())
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
//    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action:  #selector(swiped))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
       self.view.addGestureRecognizer(swipeRight)

       let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
       self.view.addGestureRecognizer(swipeLeft)

        
        super.viewDidLoad()
        
//        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
//        view.addSubview(collectionView)
        
//        if images.isEmpty {
//            emptyGalleryNotifyLabel.text = "You have no photos currently."
//        }
//        else {
//            emptyGalleryNotifyLabel.text = ""
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
        images = []
        imageNames = []
        readImagesFromLocal()
        
//        if images.isEmpty {
//            emptyGalleryNotifyLabel.text = "You have no photos currently."
//        }
//        else {
//            emptyGalleryNotifyLabel.text = ""
//        }
    }
    
    @objc  func swiped(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            if (self.tabBarController?.selectedIndex)! < 2
            { // set here  your total tabs
                self.tabBarController?.selectedIndex += 1
            }
        } else if gesture.direction == .right {
            if (self.tabBarController?.selectedIndex)! > 0 {
                self.tabBarController?.selectedIndex -= 1
            }
        }
    }

    
    func readImagesFromLocal() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let directoryURL = documentsURL.appendingPathComponent(directoryName)
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            imageNames = fileURLs
            // process files
            
            for fileUrl in fileURLs {
                guard let currImage = UIImage(contentsOfFile: fileUrl.path) else {
                    continue
                }
                images.append(currImage)
            }
        } catch {
            print(error)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        if let
            imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier, for: indexPath) as? GalleryCollectionViewCell {
            imageCell.configure(with: images[indexPath.row])
            cell = imageCell
        }
        
        return cell
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width/2) - 10, height: (view.frame.size.width/2) - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 7, bottom: 30, right: 7)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Image selected \(indexPath.row)")
//        collectionView.deselectItem(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "ZoomableViewController") as! ZoomableViewController ;
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        vc.imageUrl = imageNames[indexPath.row]
        self.present(vc, animated: true, completion: nil);
    }
    

}
