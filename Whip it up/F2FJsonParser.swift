//
//  F2FJsonParser.swift
//  curl
//
//  Created by Kory E King on 11/11/16.
//  Copyright © 2016 Kory E King. All rights reserved.
//

import Foundation
import UIKit

class F2FJsonParser {
    
    var page = 1
    var mReicpeList = [Dictionary<String, String>()]
    var imgList =  Array<UIImage>()
    var searchString = ""
    
    private func createLink(list: String, page: Int)->NSURL?{
        
        let urlComp = NSURLComponents(string: mCONSTANTS.food2fork.link)
        var linkparams = Dictionary<String, String>()
        linkparams[mCONSTANTS.food2fork.linkKeys.page] = "\(page)"
        linkparams[mCONSTANTS.food2fork.linkKeys.query] = list
        linkparams[mCONSTANTS.food2fork.linkKeys.key] = mCONSTANTS.food2fork.apiKey
        
        var query = Array<NSURLQueryItem>()
        
        for (key, value) in linkparams{
            query.append(NSURLQueryItem(name: key, value: value))
        }
        
        urlComp?.queryItems = query
        print(urlComp?.string)
        return urlComp?.URL
    }
    
    private func getJsonFromLink(url: NSURL){
        var currentItem = Dictionary<String, String>()
        let request = NSMutableURLRequest(URL: url)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithRequest(request, completionHandler:
            {
                (data, response, error) in
                if let mError = error {
                    print("Mayday we have a problem: \(mError)")
                }else if let _ =  response, mData = data{
                    var jError: NSError?
                    let parseData = JSON.init(data: mData, options: NSJSONReadingOptions.AllowFragments, error: &jError)
                    
                    for item in parseData[mCONSTANTS.food2fork.resultKey.recipe].arrayValue{
                        currentItem[mCONSTANTS.food2fork.resultKey.title] = item[mCONSTANTS.food2fork.resultKey.title].stringValue
                        currentItem[mCONSTANTS.food2fork.resultKey.sourceURL] = item[mCONSTANTS.food2fork.resultKey.sourceURL].stringValue
                        currentItem[mCONSTANTS.food2fork.resultKey.publisher] = item[mCONSTANTS.food2fork.resultKey.publisher].stringValue
                        self.mReicpeList.append(currentItem)
                    }
                    print(self.mReicpeList)
                }
            }
        )
        
        task.resume()

    }
    
    func search(list: String){
        searchString = list
        getJsonFromLink(createLink(searchString, page: page)!)
    }
    
    //implemental
    
    func loadNextPage(){
        page += 1
        search(searchString)
    }
}