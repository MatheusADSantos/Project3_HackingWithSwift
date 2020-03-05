//
//  ViewController.swift
//  Project1_HackingWithSwift
//
//  Created by macbook-estagio on 27/02/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm View"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareMessage))
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        var items = try! fm.contentsOfDirectory(atPath: path)
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        items.sort()
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        cell.imageView?.image = UIImage(named: pictures[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.layer.cornerRadius = 25
        cell.imageView?.layer.masksToBounds = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let section = indexPath.section
        
        for row in 0..<pictures.count {
            if let cell = tableView.cellForRow(at: IndexPath(row: row, section: section)) {
                cell.accessoryType = row == indexPath.row ? .checkmark : .disclosureIndicator
                cell.textLabel?.font = (row == indexPath.row) ? (UIFont(name: "Symbol", size: 24)) : (UIFont(name: "System", size: 17))
                }
            }
        
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
//            vc.titleImage =  "\(indexPath.row+1)/\(pictures.count)"
            vc.titleImage = pictures[indexPath.row]

            if let navigation = navigationController {
                navigation.pushViewController(vc, animated: true)
            }
        }
    }
    
    @objc func shareMessage() {
        let activityVC = UIActivityViewController.init(activityItems: ["Hi friend! This is awesome app! Download here https://itunes.apple.com/us/app/myapp/idxxxxxxxx?ls=1&mt="], applicationActivities: [])
        activityVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activityVC, animated: true)
    }
    
    
    

}

