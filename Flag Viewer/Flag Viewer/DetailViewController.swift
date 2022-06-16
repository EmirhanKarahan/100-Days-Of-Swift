//
//  DetailViewController.swift
//  Flag Viewer
//
//  Created by Emirhan KARAHAN on 15.06.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var selectedCountry:String?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageToLoad = selectedCountry {
            imageView.image = UIImage(named: imageToLoad)
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = UIColor.gray.cgColor;
        }
    }
    
    @objc func shareTapped(){
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("no image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image,"\(selectedCountry!.uppercased()) flag"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}
