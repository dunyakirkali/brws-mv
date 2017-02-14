//
//  PlaceholderTableViewCell.swift
//  brws-mv
//
//  Created by Dunya Kirkali on 2/12/17.
//  Copyright © 2017 Dunya Kirkali. All rights reserved.
//

import UIKit

class PlaceholderTableViewCell: UITableViewCell {
    
    let endGetNotificationName = Notification.Name("endGet")
    let startGetNotificationName = Notification.Name("startGet")

    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var placeholderLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.hideLoader), name: endGetNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.showLoader), name: startGetNotificationName, object: nil)
        
        loader.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showLoader() {
        loader.isHidden = false
        loader.startAnimating()
        placeholderLabel.isHidden = true
    }
    
    func hideLoader() {
        loader.isHidden = true
        loader.stopAnimating()
        placeholderLabel.isHidden = false
    }
}
