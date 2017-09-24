//
//  Business.swift
//  Yelpy
//
//  Created by Kavita Gaitonde on 9/20/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

import Foundation
import MapKit

class Business: NSObject, MKAnnotation {
    let name: String?
    let address: String?
    let displayAddress: String?
    let coordinate: CLLocationCoordinate2D
    let imageURL: URL?
    let categories: String?
    let distance: String?
    let ratingImageURL: URL?
    let reviewCount: NSNumber?
    let phone: String?
    let displayPhone: String?
    var title: String? {
        return name!
    }
    var subtitle: String? {
        return address! + " (" + categories! + ")"
    }
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        
        let imageURLString = dictionary["image_url"] as? String
        if imageURLString != nil {
            imageURL = URL(string: imageURLString!)!
        } else {
            imageURL = nil
        }
        
        let location = dictionary["location"] as? NSDictionary
        if location != nil {
            var address = ""
            let addressArray = location!["address"] as? NSArray
            if addressArray != nil && addressArray!.count > 0 {
                address = addressArray![0] as! String
            }
            
            let neighborhoods = location!["neighborhoods"] as? NSArray
            if neighborhoods != nil && neighborhoods!.count > 0 {
                if !address.isEmpty {
                    address += ", "
                }
                address += neighborhoods![0] as! String
            }
            self.address = address
            let fullAddress = location!["display_address"] as? NSArray
            if fullAddress != nil {
                self.displayAddress = fullAddress?.componentsJoined(by: ",")
            } else {
                self.displayAddress = address
            }
            
            let ll = location!["coordinate"] as? [String: Double]
            if ll != nil {
                self.coordinate = CLLocationCoordinate2D(latitude: (ll?["latitude"]!)!, longitude: (ll?["longitude"]!)!)
            } else {
                self.coordinate = CLLocationCoordinate2D()
            }
        } else {
            self.address = ""
            self.displayAddress = self.address
            self.coordinate = CLLocationCoordinate2D()
        }
        
        let categoriesArray = dictionary["categories"] as? [[String]]
        if categoriesArray != nil {
            var categoryNames = [String]()
            for category in categoriesArray! {
                let categoryName = category[0]
                categoryNames.append(categoryName)
            }
            categories = categoryNames.joined(separator: ", ")
        } else {
            categories = nil
        }
        
        let distanceMeters = dictionary["distance"] as? NSNumber
        if distanceMeters != nil {
            let milesPerMeter = 0.000621371
            distance = String(format: "%.2f mi", milesPerMeter * distanceMeters!.doubleValue)
        } else {
            distance = nil
        }
        
        let ratingImageURLString = dictionary["rating_img_url_large"] as? String
        if ratingImageURLString != nil {
            ratingImageURL = URL(string: ratingImageURLString!)
        } else {
            ratingImageURL = nil
        }
        
        reviewCount = dictionary["review_count"] as? NSNumber
        phone = dictionary["phone"] as? String
        displayPhone = dictionary["display_phone"] as? String
    }
    
    class func businesses(array: [NSDictionary]) -> [Business] {
        var businesses = [Business]()
        for dictionary in array {
            let business = Business(dictionary: dictionary)
            businesses.append(business)
        }
        return businesses
    }
    
    class func searchWithTerm(term: String, completion: @escaping ([Business]?, Error?) -> Void) {
        _ = YelpClient.sharedInstance.searchWithTerm(term, completion: completion)
    }
    
    class func searchWithTerm(filter: Filter, completion: @escaping ([Business]?, Error?) -> Void) -> Void {
        _ = YelpClient.sharedInstance.searchWithTerm(filter.searchTerm ?? "", sort: filter.sortMode, categories: filter.categories, deals: filter.dealsOn, offset: filter.currentOffset, completion: completion)
    }
    class func searchWithTerm(term: String, sort: YelpSortMode?, categories: [String]?, deals: Bool?, completion: @escaping ([Business]?, Error?) -> Void) -> Void {
        _ = YelpClient.sharedInstance.searchWithTerm(term, sort: sort, categories: categories, deals: deals, offset: 0, completion: completion)
    }
}

