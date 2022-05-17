//
//  SuccessScreenViewController.swift
//  relive
//
//  Created by Tanya Lohiya on 5/16/22.
//

import UIKit

class SuccessScreenViewController: UIViewController {
        
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var successImage: UIImageView!
    
    @IBOutlet weak var downloadImageView: UIImageView!
    
    @IBOutlet weak var uploadImageView: UIImageView!
    
    @IBOutlet weak var processingInProgressLbl: UILabel!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var imageData: String = ""
    
    @IBOutlet weak var processedImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.startAnimating()
        makePostCall(imageString: imageData)
        loader.hidesWhenStopped = true
        loader.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        cancelButton.imageView?.contentMode = .scaleAspectFit
       
    }
    
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data(base64Encoded: imageBase64String)
        let image = UIImage(data: imageData!)
        return image!
    }
    
    func makePostCall (imageString :String) {
        
        var enhancedImage:UIImage = UIImage();
        let request = Request(image: imageString, operation: "ENHANCE")
        guard let jsonData = try? JSONEncoder().encode(request) else {
                    print("Error: Trying to convert model to JSON data")
                    return
                }
        guard let url = URL(string: "http://54.145.116.66:3000/run-python") else {
                    print("Error: cannot create URL")
                    return
                }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        urlRequest.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                    guard error == nil else {
                        print("Error: error calling POST")
                        print(error!)
                        return
                    }
                    guard let data = data else {
                        print("Error: Did not receive data")
                        return
                    }
                    guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                        
                        print(response)
                        print("Error: HTTP request failed")
                        return
                    }
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            print("Error: Cannot convert data to JSON object")
                            return
                        }

                        guard let formattedJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                            print("Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }
                        
                        let jsonResponse: Response = try! JSONDecoder().decode(Response.self, from: formattedJsonData)
                        
                        enhancedImage = self.convertBase64StringToImage(imageBase64String:jsonResponse.restored_image)
                        self.processedImageView.image = enhancedImage
                        
                        self.loader.stopAnimating()
                        self.processingInProgressLbl.text = ""
                        self.successImage.image = UIImage(systemName: "checkmark.circle.fill")
                        self.uploadImageView.image = UIImage(systemName: "square.and.arrow.down")
                        self.downloadImageView.image = UIImage(systemName: "square.and.arrow.up")
                        
                    } catch {
                        print("Error: Trying to convert JSON data to string")
                    }
                    
                }
            task.resume()

        }
    
    
    struct Response: Codable {
        let status: String
        let restored_image: String
    }
    
    struct Request: Codable {
        let image: String
        let operation :String
    }

    
}
