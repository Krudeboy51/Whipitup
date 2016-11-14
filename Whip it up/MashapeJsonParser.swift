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
    
    var mRecipeDetailList = [Dictionary<String, String>()]
    
    func createLink(url_S: String)->NSURL?{
        let urlComp = NSURLComponents(string: mCONSTANTS.mashape.serverLink)
        var linkparams = Dictionary<String, String>()
        linkparams[mCONSTANTS.mashape.linkKeys.url] = url_S
        //linkparams[mCONSTANTS.mashape.linkKeys.forceExtraction] = "false"
        
        var query = Array<NSURLQueryItem>()
        
        for (key, value) in linkparams{
            query.append(NSURLQueryItem(name: key, value: value))
        }
        
        urlComp?.queryItems = query
        print(urlComp?.string)
        return urlComp?.URL
    }
    
    func getJsonFromLink(url: String){
        var currentItem = Dictionary<String, String>()
        var mURL = url.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
        mURL = mURL?.stringByReplacingOccurrencesOfString(":", withString: "")
        let request = NSMutableURLRequest(URL: createLink(mURL!)!)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithRequest(request, completionHandler:
            {
                (data, response, error) in
                if let mError = error {
                    print("Mayday we have a problem: \(mError)")
                }else if let _ =  response, mData = data{
                    var jError: NSError?
                    let parseData = JSON.init(data: mData, options: NSJSONReadingOptions.AllowFragments, error: &jError)
                    
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
       
    }
}