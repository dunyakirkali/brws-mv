//
//  MovieCellTableViewCell.swift
//  brws-mv
//
//  Created by Dunya Kirkali on 2/11/17.
//  Copyright © 2017 Dunya Kirkali. All rights reserved.
//

import UIKit

class MovieCellTableViewCell: UITableViewCell {
    
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var movieName: UILabel!
    @IBOutlet var masker: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
