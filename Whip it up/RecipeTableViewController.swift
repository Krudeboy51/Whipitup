//
//  RecipeTableViewController.swift
//  Whip it up
//
//  Created by Kory E King on 11/7/16.
//  Copyright © 2016 Kory E King. All rights reserved.
//

import UIKit



class RecipeTableViewController: UITableViewController,  UISearchBarDelegate {
    
    var jsonParser = F2FJsonParser()
    let searchController = UISearchController(searchResultsController: nil)
    var mainlist = [Dictionary<String, String>]()
    var searchString = ""
    var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        jsonParser.search("")
        mainlist = jsonParser.mReicpeList
        jsonParser.mReicpeList.removeAtIndex(0)
        print(jsonParser.mReicpeList.count)
        
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "search e.g. eggs"
        searchController.searchBar.delegate = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonParser.mReicpeList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomTBVCell
        let mDict: Dictionary<String, String> = jsonParser.mReicpeList[indexPath.row]
        
        if jsonParser.mReicpeList.count > 1{
            let img = NSURL(string: mDict[mCONSTANTS.food2fork.resultKey.imageURL]!)
            var pub = mDict[mCONSTANTS.food2fork.resultKey.publisher]
            pub = pub?.stringByReplacingOccurrencesOfString("http://", withString: "")
            cell.rectitle.text = mDict[mCONSTANTS.food2fork.resultKey.title]
            cell.pub.text = pub
            let data = NSData(contentsOfURL: img!)
            if data != nil{
                cell.recimage.image = UIImage(data: data!)
            }
            
        }else{
            cell.rectitle.text = "Sorry we did not find any recipes, please try again :-("
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
 
    
    func loadAsyncImgs(url: String, imgV: UIImageView, position: Int){
        let dlQueue = dispatch_queue_create("com.mrkking.whipitup", nil)
        
        dispatch_async(dlQueue){
            let data = NSData(contentsOfURL: NSURL(string: url)!)
            
            var image: UIImage?
            
            if data != nil{
                image = UIImage(data: data!)
            }else{
                print("image did not load \(position)")
                //print(self.mainlist[position])
                self.mainlist.removeAtIndex(position)
                self.tableView.reloadData()
            }
            
            dispatch_async(dispatch_get_main_queue()){
                imgV.image = image
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //let dict = mainlist[indexPath.row]
        
        //let list = dict[mConstants.keys.ingredients]
        
        //let recipeVC = UIStoryboard(name: "main", bundle: nil).instantiateViewControllerWithIdentifier("recipeVC") as! RecipeViewController
        
        //recipeVC.list = list?.componentsSeparatedByString(",")
        
       // showDetailViewController(recipeVC, sender: self)
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        jsonParser.search(searchBar.text!)
        self.tableView.reloadData()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {

        self.tableView.reloadData()
    }
    

}
