//
//  TableViewController.swift
//  Easy Browser
//
//  Created by Emirhan KARAHAN on 18.06.2022.
//

import UIKit

class TableViewController: UITableViewController {
    var websites = ["emirhankarahan.com", "hackingwithswift.com", "github.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Simple Browser"
        navigationController?.navigationBar.prefersLargeTitles = true;
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WebView") as? WebViewController {
            vc.websites = websites
            vc.selectedWebsite = websites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
