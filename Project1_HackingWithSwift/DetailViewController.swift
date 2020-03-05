//
//  DetailViewController.swift
//  Project1_HackingWithSwift
//
//  Created by macbook-estagio on 28/02/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var selectedImage : String?
    var titleImage : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let title = titleImage {
            self.title = "This image is \(title)"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        navigationItem.largeTitleDisplayMode = .never

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("Don't have image")
            return
        }
        guard let imageName = titleImage else {
            print("Don't have name from this image")
            return
        }
        
        
        let activityVC = UIActivityViewController(activityItems: [image, imageName], applicationActivities: [])
        activityVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activityVC, animated: true)
    }

}
