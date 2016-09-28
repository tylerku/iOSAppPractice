//
//  ImageViewController.swift
//  Cassini
//
//  Created by Tyler Udy on 8/17/16.
//  Copyright © 2016 Tyler Udy. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
   
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet {
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 10.0
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    fileprivate func fetchImage() {
        if let url = imageURL {
            spinner.startAnimating()
            DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
                let contentsOfUrl = try? Data(contentsOf: url)
                DispatchQueue.main.async{
                    if url == self.imageURL {
                        if let imageData = contentsOfUrl{
                            self.image = UIImage(data: imageData)
                        } else {
                            self.spinner?.stopAnimating()
                        }
                    } else {
                        print("ignored data returned from url \(url)")
                    }
                }
            }
        }
    }
    
    fileprivate var imageView = UIImageView()
    
    fileprivate var image : UIImage? {
        get {
            return imageView.image
        }
        
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
            
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
    
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        scrollView.addSubview(imageView)
        
    
    
    }
}
