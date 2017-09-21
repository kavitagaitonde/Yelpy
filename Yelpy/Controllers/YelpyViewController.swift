//
//  YelpyViewController.swift
//  Yelpy
//
//  Created by Kavita Gaitonde on 9/18/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

import UIKit

class YelpyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var businesses : [Business] = []
    var searchTerm : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 75
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        //setup navigation bar related items
        let searchBar:UISearchBar = UISearchBar(frame: CGRect(x:20, y:0, width:self.tableView.frame.width-20, height:(self.navigationController?.navigationBar.frame.height)! - 5))
        searchBar.placeholder = "Search for Places"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar // or use self.navigationcontroller.topItem?.titleView = searchBar

        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        Business.searchWithTerm(term: self.searchTerm ?? "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
                if let businesses = businesses {
                    self.businesses = businesses
                    for business in businesses {
                        print(business.name!)
                        print(business.address!)
                    }
                } else {
                    //reset to empty
                    self.businesses = []
                }
                self.tableView.reloadData()
            })
    }

    // MARK: - Table view
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessTableViewCell", for: indexPath) as! BusinessTableViewCell
        let business = self.businesses[indexPath.row] as Business
        cell.nameLabel.text = business.name
        cell.addressLabel.text = business.address
        cell.reviewsLabel.text = "\(business.reviewCount ?? 0) reviews"
        cell.distanceLabel.text = business.distance
        cell.categoryLabel.text = business.categories
        if (business.imageURL != nil) {
            cell.businessImageView.setImageWith(business.imageURL! as URL)
        } else {
            cell.businessImageView.image = nil
        }
        if (business.ratingImageURL != nil) {
            cell.ratingImageView.setImageWith(business.ratingImageURL! as URL)
        } else {
            cell.ratingImageView.image = nil
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.businesses.count
    }
    
    // MARK: - Search Bar
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        if(searchBar.showsCancelButton == false) {
            searchBar.showsCancelButton = true
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = searchBar.text
        self.loadData()
        searchBar.resignFirstResponder()
    }
    

    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showFiltersViewController" {
            let filtersController = segue.destination as! FiltersViewController
            filtersController.searchAction = { (filters: [String: AnyObject]) in 
                print(filters)
            }
        }

    }
 

}
