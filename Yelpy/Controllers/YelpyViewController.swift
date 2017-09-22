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
    
    var infiniteScrollActivityView:InfiniteScrollActivityView?
    var isMoreDataLoading = false
    var businesses : [Business] = []
    var filter : Filter = Filter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 75
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        // Set up Infinite Scroll loading indicator
        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        infiniteScrollActivityView = InfiniteScrollActivityView(frame: frame)
        infiniteScrollActivityView!.isHidden = true
        self.tableView.addSubview(infiniteScrollActivityView!)
        
        var insets = self.tableView.contentInset
        insets.bottom += InfiniteScrollActivityView.defaultHeight + 50
        self.tableView.contentInset = insets


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
        Business.searchWithTerm(filter: self.filter, completion: { (businesses: [Business]?, error: Error?) -> Void in
                // Stop the loading indicator
                self.infiniteScrollActivityView!.stopAnimating()
                self.isMoreDataLoading = false
            
                if let businesses = businesses {
                    if(self.filter.currentOffset > 0) {
                        self.businesses += businesses
                    } else {
                        self.businesses = businesses
                    }
                    self.filter.currentOffset = self.businesses.count
                    
                    for business in businesses {
                        print(business.name!)
                        print(business.address!)
                    }
                    
                } else {
                    //reset to empty
                    self.businesses = []
                    self.filter.currentOffset = 0
                }
                self.tableView.reloadData()
            })
    }

    // MARK: - Table view
    
    /*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }*/
    
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
        self.filter.searchTerm = searchBar.text
        self.filter.currentOffset = 0 //reset it if search term changes
        self.loadData()
        searchBar.resignFirstResponder()
    }
    
    
    // MARK: - Scrollview
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            //actual hieght of the table filled in with content - height of 1 page of content
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                print("Loading more data.......offset = \(self.filter.currentOffset)")
                
                // Update position of loadingMoreView, and start loading indicator
                let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                infiniteScrollActivityView?.frame = frame
                infiniteScrollActivityView!.startAnimating()
                
                self.loadData()
            }
            
        }
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showFiltersViewController" {
            let filtersController = segue.destination as! FiltersViewController
            filtersController.searchAction = { (filter: Filter) in
                //print(filter.searchTerm)
                self.filter = filter
                self.loadData()
            }
        } else if segue.identifier == "showBusinessDetailsViewController" {
            let cell = sender as! BusinessTableViewCell
            if let indexPath = self.tableView.indexPath(for: cell) {
                let detailsController = segue.destination as! BusinessDetailsViewController
                let business = self.businesses[indexPath.row] as Business
                detailsController.business = business
                self.tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
 

}
