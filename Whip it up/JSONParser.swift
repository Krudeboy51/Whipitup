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

/*
 {
 "title":"Recipe Puppy",
 "version":0.1,
 "href":"http:\/\/www.recipepuppy.com\/",
 "results":[
    {
        "title":"Vegetable-Pasta Oven Omelet",
        "href":"http:\/\/find.myrecipes.com\/recipes\/recipefinder.dyn?action=displayRecipe&recipe_id=520763",
        "ingredients":"tomato, onions, red pepper, garlic, olive oil, zucchini, cream cheese, vermicelli, eggs, parmesan cheese, milk, italian seasoning, salt, black pepper",
        "thumbnail":"http:\/\/img.recipepuppy.com\/560556.jpg"
    }
 }
 sample link: http://www.recipepuppy.com/api/?i=onions,garlic&q=omelet&p=3
 i : comma delimited ingredients
 q : normal search query
 p : page
 format=xml : if you want xml instead of json
 */

import UIKit

class JSONParser: NSObject {
    
    private func createLink(list: String, page: Int)->NSURL?{
        
        let urlComp = NSURLComponents(string: mConstants.linkHeader)
        var linkparams = Dictionary<String, String>()
        linkparams[mConstants.linkVars.page] = "\(page)"
        linkparams[mConstants.linkVars.ingredients] = list
        
        var query = Array<NSURLQueryItem>()
        
        for (key, value) in linkparams{
            query.append(NSURLQueryItem(name: key, value: value))
        }
        
        urlComp?.queryItems = query
        print(urlComp?.string)
        return urlComp?.URL
    }
    
    
    var parsedInformation = [Dictionary<String, String>]()
    var currentDataDictionary = Dictionary<String, String>()
   // var JSONInfo = ""
   // var page = 1
    
    
    func validateParsedData(){
        var index = 0
        for i in parsedInformation{
            if i[mConstants.keys.title] == ""{
                parsedInformation.removeAtIndex(index)
            }
            index += 1
        }
    }
    
    
    //MARK: soon to be depreciated
    
    func requestJson(ingredients: String, isNewQuery: Bool = false, page: Int = 1){
        let requestURL: NSURL = createLink(ingredients, page: page)!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as! [String: AnyObject]
                    
                    if self.parsedInformation.count != 0 && isNewQuery == true{
                        self.parsedInformation.removeAll()
                    }
                   
                    if let recipes = json[mConstants.keys.results] as? [[String: AnyObject]]{
                     
                        for recipe in recipes{
                                self.currentDataDictionary[mConstants.keys.title] = recipe[mConstants.keys.title] as? String
                                self.currentDataDictionary[mConstants.keys.recURL] = recipe[mConstants.keys.recURL] as? String
                                self.currentDataDictionary[mConstants.keys.ingredients] = recipe[mConstants.keys.ingredients] as? String
                                self.currentDataDictionary[mConstants.keys.thumbURL] = recipe[mConstants.keys.thumbURL] as? String
                                self.parsedInformation.append(self.currentDataDictionary)
                            }
                        
                        self.validateParsedData()
                    }
                    //print(self.parsedInformation)
                    
                }catch{
                    print("The must be an error with the Json data: \(error)")
                }
            }
        }
        task.resume()
    }
    
}
