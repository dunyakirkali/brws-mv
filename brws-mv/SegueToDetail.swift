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
        let destinationViewControlle = self.destination;
        let sourceViewController = self.source;
        
        sourceViewController.present(destinationViewControlle, animated: false, completion: nil)
    }
}
