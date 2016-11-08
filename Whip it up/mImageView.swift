//
//  mImageView.swift
//  Whip it up
//
//  Created by Kory E King on 11/8/16.
//  Copyright © 2016 Kory E King. All rights reserved.
//

import UIKit

class mImageView: UIImageView {

    func downloadFrom(url: NSURL, contentMode mode:UIViewContentMode = .ScaleAspectFit){
        contentMode = mode
        NSURLSession.sharedSession().dataTaskWithURL(url){
            (data, response, error) in
            guard
                let response = response as! NSHTTPURLResponse where response.statusCode == 200,
                let mimeType = response?.mimeType where mimeType.hasPrefix("image"),
                let data = data where error == nil,
                let image = UIImage(data: data)
                else{
                    return
            }
            
            
        }.resume()
    }
}
