//
//  ViewController.swift
//  Shopping List
//
//  Created by Emirhan KARAHAN on 21.06.2022.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearList))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let shareListButton = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(shareList))
        toolbarItems = [spacer, shareListButton]
        navigationController?.isToolbarHidden = false
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Product", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    @objc func clearList(){
        shoppingList.removeAll()
        tableView.reloadData()
    }
    
    @objc func addItem(){
        let ac = UIAlertController(title: "Enter new product", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Add", style: .default) { [unowned self, ac] action in
            let answer = ac.textFields![0]
            self.submit(answer: answer.text!)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    func submit(answer:String){
        shoppingList.insert(answer, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc  func shareList(){
        if shoppingList.isEmpty {
            let vc = UIAlertController(title: "Warning", message: "You need to add atleast 1 item", preferredStyle: .alert)
            vc.addAction(UIAlertAction(title: "Okay", style: .cancel))
            present(vc, animated: true)
        } else {
            let vc = UIActivityViewController(activityItems: [shoppingList.joined(separator: "\n")], applicationActivities: [])
            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            present(vc, animated: true)
        }
    }
    
}

