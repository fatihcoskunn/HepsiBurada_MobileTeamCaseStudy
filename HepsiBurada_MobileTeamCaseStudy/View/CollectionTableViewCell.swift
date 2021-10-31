//
//  CollectionTableViewCell.swift
//  HepsiBurada_MobileTeamCaseStudy
//
//  Created by Mac on 30.10.2021.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionImage: UIImageView!
    @IBOutlet weak var collectionPrice: UILabel!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var collectionDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
