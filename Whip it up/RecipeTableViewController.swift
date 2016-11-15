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
        jsonParser.mReicpeList.remove(at: 0)
        print(jsonParser.mReicpeList.count)
        
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "search e.g. eggs"
        searchController.searchBar.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonParser.mReicpeList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTBVCell
        let mDict: Dictionary<String, String> = jsonParser.mReicpeList[indexPath.row]
        
        if jsonParser.mReicpeList.count > 1{
            let img = URL(string: mDict[mCONSTANTS.food2fork.resultKey.imageURL]!)
            var pub = mDict[mCONSTANTS.food2fork.resultKey.publisher]
            pub = pub?.replacingOccurrences(of: "http://", with: "")
            cell.rectitle.text = mDict[mCONSTANTS.food2fork.resultKey.title]
            cell.pub.text = pub
            let data = try? Data(contentsOf: img!)
            if data != nil{
                cell.recimage.image = UIImage(data: data!)
            }
            
        }else{
            cell.rectitle.text = "Sorry we did not find any recipes, please try again :-("
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
 
    
    func loadAsyncImgs(_ url: String, imgV: UIImageView, position: Int){
        let dlQueue = DispatchQueue(label: "com.mrkking.whipitup", attributes: [])
        
        dlQueue.async{
            let data = try? Data(contentsOf: URL(string: url)!)
            
            var image: UIImage?
            
            if data != nil{
                image = UIImage(data: data!)
            }else{
                print("image did not load \(position)")
                //print(self.mainlist[position])
                self.mainlist.remove(at: position)
                self.tableView.reloadData()
            }
            
            DispatchQueue.main.async{
                imgV.image = image
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let dict = mainlist[indexPath.row]
        
        //let list = dict[mConstants.keys.ingredients]
        
        //let recipeVC = UIStoryboard(name: "main", bundle: nil).instantiateViewControllerWithIdentifier("recipeVC") as! RecipeViewController
        
        //recipeVC.list = list?.componentsSeparatedByString(",")
        
       // showDetailViewController(recipeVC, sender: self)
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        jsonParser.search(searchBar.text!)
        self.tableView.reloadData()
    }
    
    func updateSearchResultsForSearchController(_ searchController: UISearchController) {
        
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

        self.tableView.reloadData()
    }
    

}
