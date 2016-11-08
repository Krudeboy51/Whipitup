//
//  JSONParser.swift
//  Whip it up
//
//  Created by Kory E King on 11/7/16.
//  Copyright © 2016 Kory E King. All rights reserved.
//
/*
 SAMPLE JSON:
 {
    "count": 30,
    "recipes": [
        {
            "publisher": "The Pioneer Woman",
            "f2f_url": "http://food2fork.com/view/47245",
            "title": "Macaroni and Cheese",
            "source_url": "http://thepioneerwoman.com/cooking/2009/04/macaroni-cheese/",
            "recipe_id": "47245",
            "image_url": "http://static.food2fork.com/3420436668_f56c6724c4188e3.jpg",
            "social_rank": 99.99999999999993,
            "publisher_url": "http://thepioneerwoman.com"
        }
    ]
 }
 */

import UIKit

class JSONParser: NSObject {
    
    private func createLink(list: [String], page: Int)->NSURL?{
        
        let urlComp = NSURLComponents(string: mConstants.linkHeader)
        var linkparams = Dictionary<String, String>()
        linkparams[mConstants.key] = mConstants.APIKey.food2forkAPI
        linkparams[mConstants.linkVars.query] = list.joinWithSeparator(" ")
        linkparams[mConstants.linkVars.page] = "\(page)"
        
        var query = Array<NSURLQueryItem>()
        
        for (key, value) in linkparams{
            query.append(NSURLQueryItem(name: key, value: value))
        }
        
        urlComp?.queryItems = query
        print(urlComp?.string)
        return urlComp?.URL
    }
    
    
    let mKey = "65bf042ad9f43f34d5cc710479e7fac7"
    let mainLinkHeader = "http://food2fork.com/api/search?key="
    var parsedInformation = [Dictionary<String, String>]()
    var currentDataDictionary = Dictionary<String, String>()
    var JSONInfo = ""
    var page = 1
    
    
    
    
    
    //MARK: soon to be depreciated
    
    func requestJson(list: [String]){
       // print("printing link from new func:")
       // createLink(list, page: 1)
       // print("printing link from old func:")
        let requestURL: NSURL = NSURL(string: setupLink(list, nxtPage: true))!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    let count = json["count"] as? Int
                    if count > 0{
                        if let recipes = json["recipes"] as? [[String: AnyObject]] {
                            for recipe in recipes{
                                self.currentDataDictionary["title"] = recipe["title"] as? String
                                self.currentDataDictionary["f2f_url"] = recipe["f2f_url"] as? String
                                self.currentDataDictionary["image_url"] = recipe["image_url"] as? String
                                self.currentDataDictionary["publsher_url"] = recipe["publisher_url"] as? String
                                self.currentDataDictionary["social_rank"] = recipe["social_rank"] as? String
                                self.parsedInformation.append(self.currentDataDictionary)
                            }
                        }
                    }
                }catch{
                    print("The must be an error with the Json data: \(error)")
                }
            }
        }
        task.resume()
    }
    
    func setupLink(list: [String], nxtPage: Bool) -> String{
        
        var link = mainLinkHeader+mKey+"&q="
        
        for i in list{
            link += i+"%20"
        }
        
        if nxtPage {
            link += "&page=\(page)"
            page += 1
        }
        print(link)
        return link;
    }
    
}
