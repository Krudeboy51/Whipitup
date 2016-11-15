//
//  MashapeJsonParser.swift
//  curl
//
//  Created by Kory E King on 11/11/16.
//  Copyright © 2016 Kory E King. All rights reserved.
//

import Foundation
import UIKit

/*curl --get --include 'https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/extract?forceExtraction=false&url=http%3A%2F%2Fallrecipes.com%2FRecipe%2FSlow-Cooker-Chicken-Tortilla-Soup%2FDetail.aspx' \
-H 'X-Mashape-Key: DCrlBqI7Xjmsh1CsLRHWWDX89z5rp1EvsE6jsnjkh5Nnc7Vow6'*/

class MashapeJsonParser: NSObject{
    
    var ingreditents = Dictionary<String, String>()
    var currentItem = Dictionary<String, String>()
    var recipe = RecipeModel()
    
    func createLink(_ url_S: String)->URL?{
        var urlComp = URLComponents(string: mCONSTANTS.mashape.serverLink)
        var linkparams = Dictionary<String, String>()
        linkparams[mCONSTANTS.mashape.linkKeys.url] = url_S
        //linkparams[mCONSTANTS.mashape.linkKeys.forceExtraction] = "false"
        
        var query = Array<URLQueryItem>()
        
        for (key, value) in linkparams{
            query.append(URLQueryItem(name: key, value: value))
        }
        
        urlComp?.queryItems = query
        print(urlComp?.string!)
        return urlComp?.url
    }
    
    func getJsonFromLink(_ url: String){
        var mURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        mURL = mURL?.replacingOccurrences(of: ":", with: "")
        let request = URLRequest(url: createLink(mURL!)!)
        URLSession.shared.dataTask(with: request, completionHandler:
            {
                (data, response, error) in
                if let mError = error {
                    print("Mayday we have a problem: \(mError)")
                }else if let _ =  response, let mData = data{
                    var jError: NSError?
                    let parseData = JSON.init(data: mData, options: JSONSerialization.ReadingOptions.allowFragments, error: &jError)
                    
                    self.recipe.title = parseData["title"].string!
                    self.recipe.vegan = parseData["vegan"].bool!
                    self.recipe.prepMin = parseData["preperationMinutes"].intValue
                    self.recipe.cookmin = parseData["cookingMinutes"].intValue
                    self.recipe.servings = parseData["servings"].int!
                    self.recipe.instructions = parseData["instructions"].string!
                    for item in parseData["extendedIngredients"].array!{
                       self.recipe.addIngredient(aisle: item["aisle"].stringValue, image: item["image"].stringValue, name: item["name"].stringValue, info: item["info"].stringValue)

                    }
                    
                     print(self.recipe.ingredients)
                }
        }
        ).resume()
        /*
        var currentItem = Dictionary<String, String>()
        var mURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        mURL = mURL?.replacingOccurrences(of: ":", with: "")
        let request = NSMutableURLRequest(url: createLink(mURL!)!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request, completionHandler:
            {
                (data, response, error) in
                if let mError = error {
                    print("Mayday we have a problem: \(mError)")
                }else if let _ =  response, let mData = data{
                    var jError: NSError?
                    let parseData = JSON.init(data: mData, options: JSONSerialization.ReadingOptions.allowFragments, error: &jError)
                    
                    print("SERVINGS: \(parseData[mCONSTANTS.mashape.resultsKey.prepMin].string)")
                    
                    currentItem[mCONSTANTS.mashape.resultsKey.title] = parseData[mCONSTANTS.mashape.resultsKey.title].string
                    currentItem[mCONSTANTS.mashape.resultsKey.vegan] = parseData[mCONSTANTS.mashape.resultsKey.vegan].string
                    currentItem[mCONSTANTS.mashape.resultsKey.prepMin] = parseData[mCONSTANTS.mashape.resultsKey.prepMin].string
                    currentItem[mCONSTANTS.mashape.resultsKey.cookMin] = parseData[mCONSTANTS.mashape.resultsKey.cookMin].string
                    currentItem[mCONSTANTS.mashape.resultsKey.servings] = parseData[mCONSTANTS.mashape.resultsKey.servings].string
                    self.mRecipeDetailList.append(currentItem)
                
                   // print(self.mRecipeDetailList)
                }
            }
        )
        
        task.resume()
    */
       
    }
}
