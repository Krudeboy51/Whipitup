//
//  F2FJsonParser.swift
//  curl
//
//  Created by Kory E King on 11/11/16.
//  Copyright © 2016 Kory E King. All rights reserved.
//

import Foundation
import UIKit

class F2FJsonParser: NSObject {
    
    var page = 1
    var mReicpeList = [Dictionary<String, String>()]
    var imgList =  Array<UIImage>()
    var searchString = ""
    
    fileprivate func createLink(_ list: String)->URL?{
        
        var urlComp = URLComponents(string: mCONSTANTS.mashape.serverLink)
        var linkparams = Dictionary<String, String>()
        linkparams[mCONSTANTS.mashape.linkKeys.query] = list
        
        var query = Array<URLQueryItem>()
        
        for (key, value) in linkparams{
            query.append(URLQueryItem(name: key, value: value))
        }
        
        urlComp?.queryItems = query
        print(urlComp?.string! as Any)
        return urlComp?.url
    }
    
    fileprivate func getJsonFromLink(_ url: URL){
        var currentItem = Dictionary<String, String>()
        let request = URLRequest(url: url)
        self.mReicpeList.removeAll()
        URLSession.shared.dataTask(with: request, completionHandler:
            {
                (data, response, error) in
                if let mError = error {
                    print("Mayday we have a problem: \(mError)")
                }else if let _ =  response, let mData = data{
                    var jError: NSError?
                    let parseData = JSON.init(data: mData, options: JSONSerialization.ReadingOptions.allowFragments, error: &jError)
                    let baseURI = parseData[mCONSTANTS.mashape.resultsKey.baseURI].stringValue
                    
                    for item in parseData[mCONSTANTS.mashape.resultsKey.results].arrayValue{
                        
                        currentItem[mCONSTANTS.mashape.resultsKey.id] = item[mCONSTANTS.mashape.resultsKey.id].stringValue
                        currentItem[mCONSTANTS.mashape.resultsKey.title] = item[mCONSTANTS.mashape.resultsKey.title].stringValue
                        currentItem[mCONSTANTS.mashape.resultsKey.readyMin] = item[mCONSTANTS.mashape.resultsKey.readyMin].stringValue
                        currentItem[mCONSTANTS.mashape.resultsKey.image] = "\(baseURI)\(item[mCONSTANTS.mashape.resultsKey.image].stringValue)"
                        //print("Recipe List (f2f): \(currentItem)\n\n")
                        self.mReicpeList.append(currentItem)
                    }
                    
                    
                }
        }
        ).resume()
        /*
         var currentItem = Dictionary<String, String>()
         let request = URLRequest(url: url)
         let session = URLSession(configuration: URLSessionConfiguration.default)
         let task = URLSession.shared()dataTask(with: request, completionHandler:
            {
                (data, response, error) in
                if let mError = error {
                    print("Mayday we have a problem: \(mError)")
                }else if let _ =  response, let mData = data{
                    var jError: NSError?
                    let parseData = JSON.init(data: mData, options: JSONSerialization.ReadingOptions.allowFragments, error: &jError)
         
                    for item in parseData[mCONSTANTS.food2fork.resultKey.recipe].arrayValue{
                        currentItem[mCONSTANTS.food2fork.resultKey.title] = item[mCONSTANTS.food2fork.resultKey.title].stringValue
                    currentItem[mCONSTANTS.food2fork.resultKey.sourceURL] = item[mCONSTANTS.food2fork.resultKey.sourceURL].stringValue
                    currentItem[mCONSTANTS.food2fork.resultKey.publisher] = item[mCONSTANTS.food2fork.resultKey.publisher].stringValue
                    currentItem[mCONSTANTS.food2fork.resultKey.imageURL] = item[mCONSTANTS.food2fork.resultKey.imageURL].stringValue
                    print("Recipe List (f2f): \(currentItem)\n\n")
                    self.mReicpeList.append(currentItem)
                }
         
            }
        }
        )
       
        
        task.resume()
 */
    }
    
    
    
    func search(_ list: String){
        searchString = list
        getJsonFromLink(createLink(searchString)!)
    }
    
    //implemental
    
    func loadNextPage(){
        page += 1
        search(searchString)
    }
}
