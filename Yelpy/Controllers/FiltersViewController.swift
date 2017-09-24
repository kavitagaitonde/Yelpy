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
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    //Yelp specific filters
    var isDistanceCollapsed : Bool = true
    var isSortByCollapsed : Bool = true
    var isCategoryCollapsed : Bool = true
    var distanceArray : [String] = ["Auto", "0.3 miles", "1 mile", "5 miles", "10 miles", "20 miles"]
    var sortByArray : [String] = ["Best Match", "Distance", "Highest Rated"]
    var categorySelectionDict : [Int:Bool] = [:]
    var selectedDistanceIndex = 0
    var selectedSortByIndex = 0
    var isOfferingDeal : Bool = false
    let filtersCount = 4
    let categoryArray = [["name" : "Afghan", "code": "afghani"],
                      ["name" : "African", "code": "african"],
                      ["name" : "American (New)", "code": "newamerican"],
                      ["name" : "American (Traditional)", "code": "tradamerican"],
                      ["name" : "Arabian", "code": "arabian"],
                      ["name" : "Argentine", "code": "argentine"],
                      ["name" : "Armenian", "code": "armenian"],
                      ["name" : "Asian Fusion", "code": "asianfusion"],
                      ["name" : "Asturian", "code": "asturian"],
                      ["name" : "Australian", "code": "australian"],
                      ["name" : "Austrian", "code": "austrian"],
                      ["name" : "Baguettes", "code": "baguettes"],
                      ["name" : "Bangladeshi", "code": "bangladeshi"],
                      ["name" : "Barbeque", "code": "bbq"],
                      ["name" : "Basque", "code": "basque"],
                      ["name" : "Bavarian", "code": "bavarian"],
                      ["name" : "Beer Garden", "code": "beergarden"],
                      ["name" : "Beer Hall", "code": "beerhall"],
                      ["name" : "Beisl", "code": "beisl"],
                      ["name" : "Belgian", "code": "belgian"],
                      ["name" : "Bistros", "code": "bistros"],
                      ["name" : "Black Sea", "code": "blacksea"],
                      ["name" : "Brasseries", "code": "brasseries"],
                      ["name" : "Brazilian", "code": "brazilian"],
                      ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
                      ["name" : "British", "code": "british"],
                      ["name" : "Buffets", "code": "buffets"],
                      ["name" : "Bulgarian", "code": "bulgarian"],
                      ["name" : "Burgers", "code": "burgers"],
                      ["name" : "Burmese", "code": "burmese"],
                      ["name" : "Cafes", "code": "cafes"],
                      ["name" : "Cafeteria", "code": "cafeteria"],
                      ["name" : "Cajun/Creole", "code": "cajun"],
                      ["name" : "Cambodian", "code": "cambodian"],
                      ["name" : "Canadian", "code": "New)"],
                      ["name" : "Canteen", "code": "canteen"],
                      ["name" : "Caribbean", "code": "caribbean"],
                      ["name" : "Catalan", "code": "catalan"],
                      ["name" : "Chech", "code": "chech"],
                      ["name" : "Cheesesteaks", "code": "cheesesteaks"],
                      ["name" : "Chicken Shop", "code": "chickenshop"],
                      ["name" : "Chicken Wings", "code": "chicken_wings"],
                      ["name" : "Chilean", "code": "chilean"],
                      ["name" : "Chinese", "code": "chinese"],
                      ["name" : "Comfort Food", "code": "comfortfood"],
                      ["name" : "Corsican", "code": "corsican"],
                      ["name" : "Creperies", "code": "creperies"],
                      ["name" : "Cuban", "code": "cuban"],
                      ["name" : "Curry Sausage", "code": "currysausage"],
                      ["name" : "Cypriot", "code": "cypriot"],
                      ["name" : "Czech", "code": "czech"],
                      ["name" : "Czech/Slovakian", "code": "czechslovakian"],
                      ["name" : "Danish", "code": "danish"],
                      ["name" : "Delis", "code": "delis"],
                      ["name" : "Diners", "code": "diners"],
                      ["name" : "Dumplings", "code": "dumplings"],
                      ["name" : "Eastern European", "code": "eastern_european"],
                      ["name" : "Ethiopian", "code": "ethiopian"],
                      ["name" : "Fast Food", "code": "hotdogs"],
                      ["name" : "Filipino", "code": "filipino"],
                      ["name" : "Fish & Chips", "code": "fishnchips"],
                      ["name" : "Fondue", "code": "fondue"],
                      ["name" : "Food Court", "code": "food_court"],
                      ["name" : "Food Stands", "code": "foodstands"],
                      ["name" : "French", "code": "french"],
                      ["name" : "French Southwest", "code": "sud_ouest"],
                      ["name" : "Galician", "code": "galician"],
                      ["name" : "Gastropubs", "code": "gastropubs"],
                      ["name" : "Georgian", "code": "georgian"],
                      ["name" : "German", "code": "german"],
                      ["name" : "Giblets", "code": "giblets"],
                      ["name" : "Gluten-Free", "code": "gluten_free"],
                      ["name" : "Greek", "code": "greek"],
                      ["name" : "Halal", "code": "halal"],
                      ["name" : "Hawaiian", "code": "hawaiian"],
                      ["name" : "Heuriger", "code": "heuriger"],
                      ["name" : "Himalayan/Nepalese", "code": "himalayan"],
                      ["name" : "Hong Kong Style Cafe", "code": "hkcafe"],
                      ["name" : "Hot Dogs", "code": "hotdog"],
                      ["name" : "Hot Pot", "code": "hotpot"],
                      ["name" : "Hungarian", "code": "hungarian"],
                      ["name" : "Iberian", "code": "iberian"],
                      ["name" : "Indian", "code": "indpak"],
                      ["name" : "Indonesian", "code": "indonesian"],
                      ["name" : "International", "code": "international"],
                      ["name" : "Irish", "code": "irish"],
                      ["name" : "Island Pub", "code": "island_pub"],
                      ["name" : "Israeli", "code": "israeli"],
                      ["name" : "Italian", "code": "italian"],
                      ["name" : "Japanese", "code": "japanese"],
                      ["name" : "Jewish", "code": "jewish"],
                      ["name" : "Kebab", "code": "kebab"],
                      ["name" : "Korean", "code": "korean"],
                      ["name" : "Kosher", "code": "kosher"],
                      ["name" : "Kurdish", "code": "kurdish"],
                      ["name" : "Laos", "code": "laos"],
                      ["name" : "Laotian", "code": "laotian"],
                      ["name" : "Latin American", "code": "latin"],
                      ["name" : "Live/Raw Food", "code": "raw_food"],
                      ["name" : "Lyonnais", "code": "lyonnais"],
                      ["name" : "Malaysian", "code": "malaysian"],
                      ["name" : "Meatballs", "code": "meatballs"],
                      ["name" : "Mediterranean", "code": "mediterranean"],
                      ["name" : "Mexican", "code": "mexican"],
                      ["name" : "Middle Eastern", "code": "mideastern"],
                      ["name" : "Milk Bars", "code": "milkbars"],
                      ["name" : "Modern Australian", "code": "modern_australian"],
                      ["name" : "Modern European", "code": "modern_european"],
                      ["name" : "Mongolian", "code": "mongolian"],
                      ["name" : "Moroccan", "code": "moroccan"],
                      ["name" : "New Zealand", "code": "newzealand"],
                      ["name" : "Night Food", "code": "nightfood"],
                      ["name" : "Norcinerie", "code": "norcinerie"],
                      ["name" : "Open Sandwiches", "code": "opensandwiches"],
                      ["name" : "Oriental", "code": "oriental"],
                      ["name" : "Pakistani", "code": "pakistani"],
                      ["name" : "Parent Cafes", "code": "eltern_cafes"],
                      ["name" : "Parma", "code": "parma"],
                      ["name" : "Persian/Iranian", "code": "persian"],
                      ["name" : "Peruvian", "code": "peruvian"],
                      ["name" : "Pita", "code": "pita"],
                      ["name" : "Pizza", "code": "pizza"],
                      ["name" : "Polish", "code": "polish"],
                      ["name" : "Portuguese", "code": "portuguese"],
                      ["name" : "Potatoes", "code": "potatoes"],
                      ["name" : "Poutineries", "code": "poutineries"],
                      ["name" : "Pub Food", "code": "pubfood"],
                      ["name" : "Rice", "code": "riceshop"],
                      ["name" : "Romanian", "code": "romanian"],
                      ["name" : "Rotisserie Chicken", "code": "rotisserie_chicken"],
                      ["name" : "Rumanian", "code": "rumanian"],
                      ["name" : "Russian", "code": "russian"],
                      ["name" : "Salad", "code": "salad"],
                      ["name" : "Sandwiches", "code": "sandwiches"],
                      ["name" : "Scandinavian", "code": "scandinavian"],
                      ["name" : "Scottish", "code": "scottish"],
                      ["name" : "Seafood", "code": "seafood"],
                      ["name" : "Serbo Croatian", "code": "serbocroatian"],
                      ["name" : "Signature Cuisine", "code": "signature_cuisine"],
                      ["name" : "Singaporean", "code": "singaporean"],
                      ["name" : "Slovakian", "code": "slovakian"],
                      ["name" : "Soul Food", "code": "soulfood"],
                      ["name" : "Soup", "code": "soup"],
                      ["name" : "Southern", "code": "southern"],
                      ["name" : "Spanish", "code": "spanish"],
                      ["name" : "Steakhouses", "code": "steak"],
                      ["name" : "Sushi Bars", "code": "sushi"],
                      ["name" : "Swabian", "code": "swabian"],
                      ["name" : "Swedish", "code": "swedish"],
                      ["name" : "Swiss Food", "code": "swissfood"],
                      ["name" : "Tabernas", "code": "tabernas"],
                      ["name" : "Taiwanese", "code": "taiwanese"],
                      ["name" : "Tapas Bars", "code": "tapas"],
                      ["name" : "Tapas/Small Plates", "code": "tapasmallplates"],
                      ["name" : "Tex-Mex", "code": "tex-mex"],
                      ["name" : "Thai", "code": "thai"],
                      ["name" : "Traditional Norwegian", "code": "norwegian"],
                      ["name" : "Traditional Swedish", "code": "traditional_swedish"],
                      ["name" : "Trattorie", "code": "trattorie"],
                      ["name" : "Turkish", "code": "turkish"],
                      ["name" : "Ukrainian", "code": "ukrainian"],
                      ["name" : "Uzbek", "code": "uzbek"],
                      ["name" : "Vegan", "code": "vegan"],
                      ["name" : "Vegetarian", "code": "vegetarian"],
                      ["name" : "Venison", "code": "venison"],
                      ["name" : "Vietnamese", "code": "vietnamese"],
                      ["name" : "Wok", "code": "wok"],
                      ["name" : "Wraps", "code": "wraps"],
                      ["name" : "Yugoslav", "code": "yugoslav"]]
    
    var searchAction : (Filter) -> Void = { (filter: Filter) in }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.frame = CGRect(x: 10, y: 0, width: self.view.frame.width-20 , height: self.view.frame.height)
       // self.tableView.backgroundColor = UIColor.clear

        //self.navigationItem.rightBarButtonItem.
        //addTarget(self, action: #selector(onSearchClicked(_:)), for: UIControlEvents.touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filtersCount
    }
    
    /*func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width , height: 40))
        view.backgroundColor = .blue
        let button = UIButton(frame: CGRect(x: self.tableView.frame.width - 100, y:0, width: 50, height: 30))
        button.backgroundColor = .red
        button.tag = section
        button.addTarget(self, action: #selector(sectionSelected(_:)), for: UIControlEvents.touchUpInside)
        view.addSubview(button)
        return view
    }*/
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch (section) {
        case 0 : //deal
            return 20
        default :
            return 40
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
                return 4
            } else {
                return self.categoryArray.count
            }
        default :
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FiltersTableViewCell", for: indexPath) as! FiltersTableViewCell
        
        cell.selectionSwitch.isHidden = true
        cell.selectionSwitch.isOn = false
        cell.accessoryType = UITableViewCellAccessoryType.none
        cell.accessoryView = nil
        cell.filterLabel?.textAlignment = .left
        switch (indexPath.section) {
        case 0 : //deal
            cell.filterLabel?.text = "Offering a Deal"
            cell.selectionSwitch.isHidden = false
            cell.selectionSwitch.isOn = self.isOfferingDeal
            cell.switchAction = { (isOn: Bool) in
                self.isOfferingDeal = isOn
            }
        case 1 : //distance
            if self.isDistanceCollapsed {
                cell.filterLabel?.text = self.distanceArray[self.selectedDistanceIndex]
                let imageView = UIImageView(image: UIImage(named: "disclosure"))
                cell.accessoryView = imageView
            } else {
                cell.filterLabel?.text = self.distanceArray[indexPath.row]
                if (indexPath.row == self.selectedDistanceIndex) {
                    cell.accessoryType = UITableViewCellAccessoryType.checkmark
                }
            }
        case 2 : // sort by
            if self.isSortByCollapsed {
                cell.filterLabel?.text = self.sortByArray[self.selectedSortByIndex]
                let imageView = UIImageView(image: UIImage(named: "disclosure"))
                cell.accessoryView = imageView
            } else {
                cell.filterLabel?.text = self.sortByArray[indexPath.row]
                if (indexPath.row == self.selectedSortByIndex) {
                    cell.accessoryType = UITableViewCellAccessoryType.checkmark
                }
            }
        case 3 : // category
            if self.isCategoryCollapsed && indexPath.row == 3 {
                cell.filterLabel?.text = "Show All"
                cell.filterLabel?.textAlignment = .center
            } else {
                cell.selectionSwitch.isHidden = false
                cell.filterLabel?.text = self.categoryArray[indexPath.row]["name"]
                if let val = self.categorySelectionDict[indexPath.row] {
                    cell.selectionSwitch.isOn = val
                } else {
                    cell.selectionSwitch.isOn = false
                }
                cell.switchAction = { (isOn: Bool) in
                    self.categorySelectionDict[indexPath.row] = isOn
                }
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
    
    // MARK: - Actions
    
    @IBAction func onCancelClicked(_ sender: AnyObject) {
         _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onSearchClicked(_ sender: AnyObject) {
        let filter = Filter()
        filter.dealsOn = self.isOfferingDeal
        filter.sortMode = YelpSortMode(rawValue: self.selectedSortByIndex)
        let categories = self.categorySelectionDict.keys
        var filteredCategories : [String] = []
        for k in categories {
            if self.categorySelectionDict[k]! && self.categorySelectionDict[k]! == true {
                var c = self.categoryArray[k] as Dictionary
                filteredCategories.append(c["code"]!)
            }
        }
        filter.categories = filteredCategories
        searchAction(filter as Filter)
         _ = navigationController?.popViewController(animated: true)
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
