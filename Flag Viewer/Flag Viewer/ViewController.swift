//
//  ViewController.swift
//  Flag Viewer
//
//  Created by Emirhan KARAHAN on 14.06.2022.
//

import UIKit

class ViewController: UITableViewController {
    var countries = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Flag Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].uppercased()
        cell.imageView?.image = UIImage(named: countries[indexPath.row])
        cell.imageView?.layer.borderWidth = 2;
        cell.imageView?.layer.borderColor = UIColor.white.cgColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedCountry = countries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    

}

