//
//  FiltersViewController.swift
//  Yelpy
//
//  Created by Kavita Gaitonde on 9/18/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchButton: UIBarButtonItem!
    
    
    //Yelp specific filters
    var isDistanceCollapsed : Bool = true
    var isSortByCollapsed : Bool = true
    var isCategoryCollapsed : Bool = true

    var filtersDict : [String: AnyObject] = [:]
    var distanceArray : [String] = ["Auto", "0.3 miles", "1 mile", "5 miles", "10 miles", "20 miles"]
    var sortByArray : [String] = ["Best Match"]
    var categoryArray : [String] = ["Afghan", "African", "American (New)", "See All"]
    var categoryFullArray : [String] = ["Afghan", "African", "American (New)", "American (Traditional)", "Japanese"]
    var categorySelectionDict : [Int:Bool] = [:]
    var selectedDistanceIndex = 0
    var selectedSortByIndex = 0
    let filtersCount = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filtersCount
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width , height: 40))
        view.backgroundColor = .blue
        let button = UIButton(frame: CGRect(x: self.tableView.frame.width - 100, y:0, width: 50, height: 30))
        button.backgroundColor = .red
        button.tag = section
        button.addTarget(self, action: #selector(sectionSelected(_:)), for: UIControlEvents.touchUpInside)
        view.addSubview(button)
        return view
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //return "\(section)"
        switch (section) {
        case 0 : //deal
            return ""
        case 1 : //distance
            return "Distance"
        case 2 : // sort by
            return "Sort By"
        case 3 : // category
            return "Category"
        default :
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0 : //deal
            return 1
        case 1 : //distance
            if self.isDistanceCollapsed {
                return 1
            } else {
                return self.distanceArray.count
            }
        case 2 : // sort by
            if self.isSortByCollapsed {
                return 1
            } else {
                return self.sortByArray.count
            }
        case 3 : // category
            if self.isCategoryCollapsed {
                return self.categoryArray.count
            } else {
                return self.categoryFullArray.count
            }
        default :
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        //cell.textLabel?.text = "\(indexPath.row)"
        
        switch (indexPath.section) {
        case 0 : //deal
            cell.textLabel?.text = "Offering a deal"
        case 1 : //distance
            if self.isDistanceCollapsed {
                cell.textLabel?.text = self.distanceArray[self.selectedDistanceIndex]
            } else {
                cell.textLabel?.text = self.distanceArray[indexPath.row]
            }
        case 2 : // sort by
            if self.isSortByCollapsed {
                cell.textLabel?.text = self.sortByArray[self.selectedSortByIndex]
            } else {
                cell.textLabel?.text = self.sortByArray[indexPath.row]
            }
        case 3 : // category
            if self.isCategoryCollapsed {
                cell.textLabel?.text = self.categoryArray[indexPath.row]
            } else {
                cell.textLabel?.text = self.categoryFullArray[indexPath.row]
            }
        default :
            break
        }
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section) {
        case 1 : //distance
            if self.isDistanceCollapsed {
                self.isDistanceCollapsed = false
            } else {
                self.selectedDistanceIndex = indexPath.row
                self.isDistanceCollapsed = true
            }
        case 2 : // sort by
            if self.isSortByCollapsed {
                self.isSortByCollapsed = false
            } else {
                self.selectedSortByIndex = indexPath.row
                self.isSortByCollapsed = true
            }
        case 3 : // category
            if self.isCategoryCollapsed && indexPath.row == 3 {
                self.isCategoryCollapsed = false
            }
        default :
            break
        }
        self.tableView.reloadData()
    }
    
    func sectionSelected(_ sender : UIButton) {
        switch (sender.tag) {
        case 1 : //distance
            if self.isDistanceCollapsed {
                self.isDistanceCollapsed = false
            } else {
                self.isDistanceCollapsed = true
            }
        case 2 : // sort by
            if self.isSortByCollapsed {
                self.isSortByCollapsed = false
            } else {
                self.isSortByCollapsed = true
            }
        case 3 : // category
            if self.isCategoryCollapsed {
                self.isCategoryCollapsed = false
            } else {
                self.isCategoryCollapsed = true
            }
        default :
            break
        }

        self.tableView.reloadData()
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
