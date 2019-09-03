//
//  ViewController.swift
//  ProgrammingAssignment
//
//  Created by Junjie Xu on 9/2/19.
//  Copyright © 2019 Junjie Xu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var attractionNameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        attractionNameLabel.text = "Default Attraction"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameTextField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        attractionNameLabel.text = textField.text
        textField.text = ""
    }
    @IBOutlet weak var RatingControl1: RatingControl!
    
    @IBAction func selectImageFromPhotoLibrary (_ sender: UITapGestureRecognizer) {
        
        print("hello")
        nameTextField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }

    @IBOutlet weak var ratingControl: RatingControl!
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        photoImageView.image = selectedImage
        dismiss(animated: true, completion:nil)
    }
        
    @IBAction func submitDataToFirebase(_ sender: Any) {
        
        let url = URL(string: "https://mas-db.firebaseio.com/attraction_submit.json")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let data = ["attraction_name": attractionNameLabel.text!, "image":"image",
                    "rating":NSNumber(integerLiteral: RatingControl1.rating).stringValue]
        
        do{
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        } catch let error {
            print (error)
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil{
                print (error!)
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse)
                
                if httpResponse.statusCode == 200{
                    
                    DispatchQueue.main.async(execute: {
                        self.attractionNameLabel.text = "Attraction Name"
                        self.nameTextField.text = ""
                        self.RatingControl1.rating = 0
                    })
                }
            }
        }
        
        task.resume()
        
        
        
    }
}

