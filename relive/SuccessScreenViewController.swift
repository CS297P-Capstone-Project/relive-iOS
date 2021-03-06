//
//  SuccessScreenViewController.swift
//  relive
//
//  Created by Tanya Lohiya on 5/16/22.
//

import UIKit

class SuccessScreenViewController: UIViewController {
    
    @IBOutlet weak var beforeAfterView: BeforeAfterView!
        
    @IBOutlet weak var cancelButton: UIButton!
    
//    @IBOutlet weak var successImage: UIImageView!
    
    @IBOutlet weak var shareImageView: UIImageView!
    
//    @IBOutlet weak var processingInProgressLbl: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet weak var loaderGif: UIImageView!
    
//    @IBOutlet weak var loader: UIActivityIndicatorView!
    var imageData: String = ""
    var operation: String = ""
    var processedImage: UIImage = UIImage()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.shareBtn.isHidden = true
        self.shareImageView.isHidden = true
//        loader.startAnimating()
//        loader.hidesWhenStopped = true
//        loader.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        self.loaderGif.loadGif(name: "Roller-colorful")
        self.cancelButton.imageView?.contentMode = .scaleAspectFit
        topLabel.font = topLabel.font.withSize(25)
        topLabel.text = "Your image is being processed..."
        
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //comment for real testing
//        guard let image = UIImage(named: "oops1") else {
//            return
//        }
//        saveImageLocally(image: image)
//        guard let retrievedImage = retriveImageFromLocal(imageName: "test.jpeg") else {
//            return
//        }
//        processedImageView.image = retrievedImage
        
        //uncomment for real testing
        processedImage = makePostCall(imageString: imageData)
        
        topLabel.font = topLabel.font.withSize(30)
        topLabel.text = "Your image is ready!"
//        self.processedImageView.image = processedImage
        beforeAfterView.setData(image1: processedImage, image2: convertBase64StringToImage(imageBase64String: imageData), thumbColor: UIColor.red)
        
//        self.loader.stopAnimating()
//        self.processingInProgressLbl.text = ""
//                        self.successImage.image = UIImage(systemName: "checkmark.circle.fill")
        
        self.shareBtn.isHidden = false
        self.shareImageView.isHidden = false
//        self.shareImageView.image = UIImage(systemName: "square.and.arrow.up.circle.fill")

//        self.successImage.loadGif(name: "check-mark-success")
        
        self.loaderGif.isHidden = true
    }
    
    func removeGif() {
        do {
            sleep(300)
//            try await Task.sleep(nanoseconds: UInt64(1.5 * Double(NSEC_PER_SEC)))
//            successImage.isHidden = true
        } catch {
            
        }
        // Put your code which should be executed with a delay here
    }
   
    @IBAction func shareBtnPressed(_ sender: Any) {
        let image = self.processedImage

        // set up activity view controller
        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data(base64Encoded: imageBase64String)
        let image = UIImage(data: imageData!)
        return image!
    }
    
    func getUrl(operation:String) -> URL! {
        if operation=="ENHANCE" {
            return URL(string: "http://54.145.116.66:3000/relive-image")
            //mock api
//            return URL(string: "http://54.145.116.66:3000/restore-image")
        } else if operation=="COLORIZE" {
            return URL(string: "http://54.145.116.66:3000/relive-image")
        } else {
            //mock api
//            return URL(string: "http://54.145.116.66:3000/restore-image")
            return URL(string: "http://54.145.116.66:3000/relive-image")
        }
    }
    
    func makePostCall (imageString :String) -> UIImage {
        
        var semaphore = DispatchSemaphore(value: 0)
        
        var processedImage:UIImage = UIImage();
        //TO DO
        var request: Request
        if operation == "UNSCRATCH" {
            request = Request(image: imageString, operation: "ENHANCE", has_scratches: true)
        } else if operation == "COLORIZE" {
            request = Request(image: imageString, operation: "COLORIZE", has_scratches: true)
        } else {
            request = Request(image: imageString, operation: "ENHANCE", has_scratches: false)
        }
        guard let jsonData = try? JSONEncoder().encode(request) else {
                    print("Error: Trying to convert model to JSON data")
                    errorHandler()
                    return processedImage
                }
        
        
        guard let url = getUrl(operation: operation) else {
                    print("Error: cannot create URL")
                    errorHandler()
                    return processedImage
                }
        var urlRequest = URLRequest(url: url, timeoutInterval: 60)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        urlRequest.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [self] data, response, error in
                    guard error == nil else {
                        print("Error: error calling POST")
                        print(error!)
                        errorHandler()
                        semaphore.signal()
                        return
                    }
                    guard let data = data else {
                        print("Error: Did not receive data")
                        errorHandler()
                        semaphore.signal()
                        return
                    }
                    guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                        
                        print(response)
                        print("Error: HTTP request failed")
                        errorHandler()
                        semaphore.signal()
                        return
                    }
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            print("Error: Cannot convert data to JSON object")
                            errorHandler()
                            semaphore.signal()
                            return
                        }

                        guard let formattedJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                            print("Error: Cannot convert JSON object to Pretty JSON data")
                            errorHandler()
                            semaphore.signal()
                            return 
                        }
                       
                        
                        let jsonResponse: Response = try! JSONDecoder().decode(Response.self, from: formattedJsonData)
                        
                        processedImage = self.convertBase64StringToImage(imageBase64String:jsonResponse.restored_image)
                        saveImageLocally(image: processedImage)
                       
                        semaphore.signal()
                        
                        
                    } catch {
                        print("Error: Trying to convert JSON data to string")
                        errorHandler()
                        semaphore.signal()
                    }
                    
                }
            task.resume()
            semaphore.wait()
            return processedImage
        }
    
    func saveImageLocally(image: UIImage) {
        guard
            let data = image.jpegData(compressionQuality: 1.0) else {
            print("Error getting image data.")
            return
        }
        guard
            let path = FileManager
                .default
                .urls(for: .documentDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(generateCurrentTimeStamp() + ".jpeg") else {
            print("Error getting path.")
            return
        }
        do {
            try data.write(to: path)
            print ("Image saved locally.")
        } catch let error {
            print("Error saving locally. \(error)")
        }
    }
    
    func generateCurrentTimeStamp () -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
        return (formatter.string(from: Date()) as NSString) as String
    }
    
    func errorHandler() {
//        self.loader.stopAnimating()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "ErrorPopUp") as! ErrorViewController
        vc.modalPresentationStyle = .fullScreen
        vc.errorText = "Unable to connect to server. Please check your internet and try again."
        vc.cancelBtnRedirectVCId = "TabBarController"
        self.present(vc, animated: true, completion: nil);
    }
    
    
    struct Response: Codable {
        let status: String
        let restored_image: String
//        let capacity_left: String
    }
    
    struct Request: Codable {
        let image: String
        let operation :String
        let has_scratches: Bool
    }

    
}
