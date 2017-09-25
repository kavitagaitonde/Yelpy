//
//  Filter.swift
//  Yelpy
//
//  Created by Kavita Gaitonde on 9/21/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

import Foundation

class Filter: NSObject {
    var searchTerm: String?
    var sortMode: YelpSortMode?
    var categories: [String]?
    var dealsOn: Bool = false
    var distance: Double = 0
    var currentOffset = 0

    override init() {
        super.init()
        currentOffset = 0
        searchTerm = ""
        sortMode = YelpSortMode.bestMatched
        categories = []
        dealsOn = false
        distance = 0
    }
    
    init(dictionary: NSDictionary) {
        searchTerm = dictionary["term"] as? String
        sortMode = dictionary["term"] as? YelpSortMode
        categories = dictionary["categories"] as? [String]
        dealsOn = dictionary["dealsOn"] as! Bool
        currentOffset = dictionary["offset"] as! Int
        distance = dictionary["offset"] as! Double
    }
    
}
