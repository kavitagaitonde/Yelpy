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
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var business : Business?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.photoImageView.layer.cornerRadius = 5.0
        self.photoImageView.clipsToBounds = true
        self.updateViewForBusiness()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateViewForBusiness() {
        if (self.business != nil) {
            self.nameLabel.text = self.business!.name
            self.addressLabel.text = self.business!.displayAddress
            self.reviewsLabel.text = "\(self.business!.reviewCount ?? 0) reviews"
            self.distanceLabel.text = self.business!.distance
            self.categoryLabel.text = self.business!.categories
            if (self.business!.imageURL != nil) {
             self.photoImageView.setImageWith(self.business!.imageURL! as URL)
             } else {
             self.photoImageView.image = nil
             }
            if (self.business!.ratingImageURL != nil) {
                self.ratingImageView.setImageWith(self.business!.ratingImageURL! as URL)
            } else {
                self.ratingImageView.image = nil
            }
            let centerLocation = CLLocation(latitude: self.business!.getLatitude(), longitude: self.business!.getLongitude())
            goToLocation(location: centerLocation)
        }
    }
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        self.mapView.setRegion(region, animated: false)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        annotation.title = "This is is!"
        mapView.addAnnotation(annotation)
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
