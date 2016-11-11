//
//  MCONSTANTS.swift
//  curl
//
//  Created by Kory E King on 11/11/16.
//  Copyright © 2016 Kory E King. All rights reserved.
//

import Foundation

class mCONSTANTS {

    //http://food2fork.com/api/search?key=65bf042ad9f43f34d5cc710479e7fac7&q=shredded%20chicken
    
    struct food2fork{
        static var link = "http://food2fork.com/api/search?"
        static var apiKey = "65bf042ad9f43f34d5cc710479e7fac7"
        struct linkKeys {
            static var query = "q"
            static var page = "page"
            static var key = "key"
        }
        struct resultKey{
            static var recipe = "recipes"
            static var title = "title"
            static var sourceURL = "source_url"
            static var publisher = "publisher_url"
        }
    }
    
   /* curl --get --include 'https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/extract?forceExtraction=false&url=http%3A%2F%2Fallrecipes.com%2FRecipe%2FSlow-Cooker-Chicken-Tortilla-Soup%2FDetail.aspx' \
    -H 'X-Mashape-Key: DCrlBqI7Xjmsh1CsLRHWWDX89z5rp1EvsE6jsnjkh5Nnc7Vow6'*/
    
    struct mashape{
        static var link = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/extract"
        static var apiKeyHeader = "X-Mashape-Key"
        static var apiKey = "DCrlBqI7Xjmsh1CsLRHWWDX89z5rp1EvsE6jsnjkh5Nnc7Vow6"
        static var serverLink = "http://mrkking.com/badman/php/Mashape.php"
        struct linkKeys{
            static var forceExtraction = "forceExtraction"
            static var url = "link"
        }
        struct resultsKey{
            static var vegan = "vegan"
            static var prepMin = "preparationMinutes"
            static var cookMin = "cookingMinutes"
            static var servings = "servings"
            static var title = "title"
            struct ingredients {
                static var amount = "amount"
                static var name = "originalString"
                static var image = "image"
                static var aisle = "aisle"
                static var unit = "unitShort"
            }
        }
    }
}