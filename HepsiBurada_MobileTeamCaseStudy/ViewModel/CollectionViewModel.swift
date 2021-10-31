//
//  CollectionViewModel.swift
//  HepsiBurada_MobileTeamCaseStudy
//
//  Created by Mac on 30.10.2021.
//

import Foundation

struct  CollectionTableViewModel {
    //init(collections:Collection){
        //let result = collections.results.filter { collection in collection.wrapperType == wrappertype }
        //self.collections = Collection(resultCount: result.count, results: result)
    //}
    let collections : Collection
    func numberOfRowsInSection() -> Int{
        return self.collections.resultCount
    }
    
    func collectionAtIndexPath(_index: Int) -> CollectionViewModel {
        let result = self.collections.results[_index]
        return CollectionViewModel(result : result)
    }
}

struct CollectionViewModel {
    let result : Result
    
    var artworkUrl100 : String {
        return self.result.artworkUrl100
    }
    var releaseDate: String {
        return self.result.releaseDate
    }
    var collectionPrice: Double {
        return self.result.collectionPrice
    }
    var collectionName: String? {
        return self.result.collectionName
    }
    var wrapperType: String {
        return self.result.wrapperType
    }
    
}
