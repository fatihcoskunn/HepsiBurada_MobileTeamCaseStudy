//
//  DetailsViewController.swift
//  HepsiBurada_MobileTeamCaseStudy
//
//  Created by Mac on 28.10.2021.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var collectionPrice: UILabel!
    @IBOutlet weak var collectionDate: UILabel!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var collectionImage: UIImageView!
    
    var collection: CollectionViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: collection.artworkUrl100)
        let data = try? Data(contentsOf: url!)
        collectionImage.image = UIImage(data: data!)
        collectionName.text = collection.collectionName
        collectionDate.text = convertToDate(value: collection.releaseDate)
        collectionPrice.text = String(collection.collectionPrice)
     
    }
    func convertToDate(value: String) -> String{
        var dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:value)!
        
        dateFormatter = DateFormatter()
        
        // Set Date Format
        dateFormatter.dateFormat = "YY/MM/dd"

        // Convert Date to String
        return dateFormatter.string(from: date)
    }
}
