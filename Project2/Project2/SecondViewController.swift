//
//  SecondViewController.swift
//  Project2
//
//  Created by user180084 on 11/23/20.
//

import UIKit

class SecondViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var openCamButton: UIButton!
    @IBOutlet weak var openAlbumbutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func openCam(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController();
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true;
            present(imagePicker, animated:true);
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image2 = info[.editedImage] as? UIImage else {
                print("No image found")
                return
            }
        ImageView.image = image2;
    }
    
    @IBAction func openAlbum(_ sender: Any) {
        let imagePicker = UIImagePickerController();
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true;
        present(imagePicker, animated:true);    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
