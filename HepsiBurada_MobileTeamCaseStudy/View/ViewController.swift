//
//  ViewController.swift
//  HepsiBurada_MobileTeamCaseStudy
//
//  Created by Mac on 28.10.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate  {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private var collectionTableViewModel: CollectionTableViewModel!
    //var collections : Collection!
    var index: Int!
    var wrapperType = "movie"
    var term = "value"
    var filter = "filter"
    var url = "https://itunes.apple.com/search?term=value&media=filter"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    @IBAction func didChangeSegment(_ sender:UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            view.backgroundColor = .purple
            self.wrapperType = "movie"
           } else if sender.selectedSegmentIndex == 1 {
               view.backgroundColor = .systemTeal
               self.wrapperType = "music"
           } else if sender.selectedSegmentIndex == 2 {
               view.backgroundColor = .systemOrange
               self.wrapperType = "all" // Since the "software" parameter could not be found from the url, the "all" parameter was selected.
               
           } else if sender.selectedSegmentIndex == 3 {
            view.backgroundColor = .systemCyan
               self.wrapperType = "audiobook"
        }
        //self.collectionTableViewModel = CollectionTableViewModel(collections: collections,wrappertype:self.wrapperType)
        veriAl()
    }
    func veriAl() {
        if term == "value" { return }
        self.collectionTableViewModel = CollectionTableViewModel(collections: Collection(resultCount: 0, results: [Result(artworkUrl100: "", collectionPrice: 0, collectionName: "", releaseDate: "", wrapperType: "")]))
        tableView.reloadData()
        self.url = self.url.replacingOccurrences(of: self.filter, with: self.wrapperType)
        self.filter = self.wrapperType
        let url = URL(string: self.url)
        WebService().collectionApi(url: url!) { (collections) in
            if let collections = collections {
                self.collectionTableViewModel = CollectionTableViewModel(collections: collections)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
            }
        }
    }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionTableViewModel == nil ? 0 : self.collectionTableViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CollectionTableViewCell
        let collectionViewModel = self.collectionTableViewModel.collectionAtIndexPath(_index: indexPath.row)

        cell.collectionName.text = collectionViewModel.collectionName
        cell.collectionPrice.text = String(collectionViewModel.collectionPrice)
        cell.collectionDate.text = convertToDate(value: collectionViewModel.releaseDate)
        let url = URL(string: collectionViewModel.artworkUrl100)
        let data = try? Data(contentsOf: url!) 
        cell.collectionImage.image = UIImage(data: data!)
     
        return cell
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.collection = self.collectionTableViewModel.collectionAtIndexPath(_index: self.index)
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count <= 2 { return }
        url = url.replacingOccurrences(of: term, with: searchText.replacingOccurrences(of: " ", with: "+"))
        self.term = searchText.replacingOccurrences(of: " ", with: "+")
        veriAl()
    }
    
}
