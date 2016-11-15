//
//  RecipeViewController.swift
//  Whip it up
//
//  Created by Kory E King on 11/7/16.
//  Copyright © 2016 Kory E King. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var ingredientstbl: UITableView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var jsonParser = MashapeJsonParser()
    
    var list = [String]()
    
    var link = "http://allrecipes.com/recipe/15840/chicken-tortilla-soup-v/?internalSource=hub%20recipe&referringContentType=search%20results&clickId=cardslot%202"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonParser.getJsonFromLink(link)
        titleLabel.text = jsonParser.recipe.title
       // webview.hidden = true
        //ingredientstbl.hidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientstbl.dequeueReusableCell(withIdentifier: "ingredientCell")!
        cell.textLabel?.text = "h"
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
