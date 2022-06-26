//
//  DetailViewController.swift
//  Captions to Photos
//
//  Created by Emirhan KARAHAN on 26.06.2022.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var photo:Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = photo?.caption
        navigationItem.largeTitleDisplayMode = .never
        
        let path = getDocumentsDirectory().appendingPathComponent(photo!.fileName)
        imageView.image = UIImage(contentsOfFile: path.path)
    
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
