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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        let searchBar:UISearchBar = UISearchBar(frame: CGRect(x:20, y:0, width:self.tableView.frame.width-20, height:(self.navigationController?.navigationBar.frame.height)! - 5))
        searchBar.placeholder = "Search for Places"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar // or use self.navigationcontroller.topItem?.titleView = searchBar

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
