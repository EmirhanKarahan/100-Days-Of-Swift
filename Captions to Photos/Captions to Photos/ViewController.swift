//
//  ViewController.swift
//  Captions to Photos
//
//  Created by Emirhan KARAHAN on 26.06.2022.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhoto))
        title = "Captions to Photos"
        
        DispatchQueue.global().async { [weak self] in
            self?.photos = Photo.getPhotosFromUserDetails()
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
    }
    
    @objc func addPhoto(){
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let photoName = UUID().uuidString
        let photoPath = getDocumentsDirectory().appendingPathComponent(photoName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: photoPath)
        }
        
        let photo = Photo(fileName: photoName, caption: "Unspecified")
        photos.append(photo)
        
        DispatchQueue.global().async {
            Photo.savePhotosToUserDetails(photos: self.photos)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Photo", for: indexPath)
        let photo = photos[indexPath.row]
        cell.textLabel?.text = photo.caption
        let path = getDocumentsDirectory().appendingPathComponent(photo.fileName)
        cell.imageView?.image = UIImage(contentsOfFile: path.path)
        cell.imageView?.layer.borderWidth = 2;
        cell.imageView?.layer.borderColor = UIColor.white.cgColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ac = UIAlertController(title: "Choose", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Change Caption", style: .default, handler: {_ in
            self.showEditBox(indexPath:indexPath)
        }))
        ac.addAction(UIAlertAction(title: "Show detailed", style: .default, handler: { _ in
            self.showDetailed(index:indexPath.row)
        }))
        present(ac, animated: true)
    }
    
    @objc func showDetailed(index:Int){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.photo = photos[index]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func showEditBox(indexPath:IndexPath) {
        let ac = UIAlertController(title: "Enter new caption", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, ac] action in
            let answer = ac.textFields![0]
            photos[indexPath.row].caption = answer.text!
            
            DispatchQueue.global().async {
                Photo.savePhotosToUserDetails(photos: self.photos)
                
                DispatchQueue.main.async {
                    self.tableView.reloadRows(at: [indexPath], with: .fade)
                }
            }
            
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    
    
    
    
    
    
}
