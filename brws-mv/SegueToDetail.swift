//
//  SegueToDetail.swift
//  brws-mv
//
//  Created by Dunya Kirkali on 2/11/17.
//  Copyright © 2017 Dunya Kirkali. All rights reserved.
//

import UIKit

class SegueToDetail: UIStoryboardSegue {

    override func perform() {
        let destinationViewController = self.destination;
        let sourceViewController = self.source as! SearchViewController
        let frame = sourceViewController.view.superview?.frame
        let width = frame!.width * -1
        let searchBar = sourceViewController.searchBar
        
        UIView.animate(withDuration: 0.5, animations: {
            searchBar?.transform = CGAffineTransform(translationX: width, y: 0)
            sourceViewController.selectedRow.masker.alpha = 0
        }, completion: { finished in
            sourceViewController.present(destinationViewController, animated: false, completion: nil)
        })
    }
}
