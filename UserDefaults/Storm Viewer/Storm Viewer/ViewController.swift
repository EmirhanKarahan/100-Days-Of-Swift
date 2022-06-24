//
//  ViewController.swift
//  Storm Viewer
//
//  Created by Emirhan KARAHAN on 10.06.2022.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var numberOfClicks = [String:Int]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path).sorted()
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        if let dict = defaults.object(forKey: "numberOfClicks") as? [String: Int]{
            numberOfClicks = dict
        } else {
            defaults.set(numberOfClicks, forKey: "numberOfClicks")
        }
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let picture = pictures[indexPath.row]
        cell.textLabel?.text = picture
        cell.detailTextLabel?.text = "Clicked \(numberOfClicks[picture] ?? 0) times"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let selectedImage = pictures[indexPath.row]
            vc.selectedImage = selectedImage
            
            if (numberOfClicks[selectedImage] != nil){
                numberOfClicks[selectedImage]! += 1
            }else{
                numberOfClicks.updateValue(1, forKey: selectedImage)
            }
            defaults.set(numberOfClicks, forKey: "numberOfClicks")
            
            vc.x = indexPath.row + 1
            vc.y = pictures.count
            tableView.reloadRows(at: [indexPath], with: .fade)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
