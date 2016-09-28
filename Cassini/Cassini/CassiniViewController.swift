//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Tyler Udy on 8/17/16.
//  Copyright © 2016 Tyler Udy. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController, UISplitViewControllerDelegate {

    fileprivate struct StoryBoard {
        static let showImageSegue = "Show Image"
    }
    
    fileprivate struct URLS {
        
        
        static let Planets = [
            "Cole" : "http://solarviews.com/raw/earth/bluemarblewest.jpg",
            "Chance" : "http://www.slate.com/content/dam/slate/blogs/bad_astronomy/2014/06/Ten%20Years%20at%20Saturn/cassini_enceladus_halflit.jpg.CROP.original-original.jpg",
            "Nance" : "https://pbs.twimg.com/profile_images/672965474142052352/6kA8gckr.jpg"
        ]
        
        static func URLImageNamed(_ name: String?) -> URL? {
            if let urlstring = Planets[name ?? ""]{
                return URL(string: urlstring)
            } else {
                return nil
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if primaryViewController.contentViewController == self{
            if let ivc = secondaryViewController.contentViewController as? ImageViewController , ivc.imageURL == nil {
                return true
            }
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryBoard.showImageSegue {
            if let ivc = segue.destination.contentViewController as? ImageViewController{
                let imageName = (sender as? UIButton)?.currentTitle
                ivc.imageURL = URLS.URLImageNamed(imageName)
                ivc.title = imageName
            }
        }
    }
    
}


extension UIViewController {
    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}
