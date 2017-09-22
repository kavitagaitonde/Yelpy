//
//  BusinessDetailsViewController.swift
//  Yelpy
//
//  Created by Kavita Gaitonde on 9/21/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

import UIKit
import MapKit

class BusinessDetailsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var reviewsLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var ratingImageView: UIImageView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var business : Business?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.updateViewForBusiness()
        
        // set starting center location in San Francisco
        let centerLocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
        goToLocation(location: centerLocation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateViewForBusiness() {
        if (self.business != nil) {
            self.nameLabel.text = self.business!.name
            self.addressLabel.text = self.business!.address
            self.reviewsLabel.text = "\(self.business!.reviewCount ?? 0) reviews"
            self.distanceLabel.text = self.business!.distance
            self.categoryLabel.text = self.business!.categories
            /*if (self.business! != nil) {
             detailsController.businessImageView.setImageWith(self.business!.imageURL! as URL)
             } else {
             detailsController.businessImageView.image = nil
             }*/
            if (self.business!.ratingImageURL != nil) {
                self.ratingImageView.setImageWith(self.business!.ratingImageURL! as URL)
            } else {
                self.ratingImageView.image = nil
            }
        }
    }
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
