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
        static let link = "http://food2fork.com/api/search?"
        static let apiKey = "65bf042ad9f43f34d5cc710479e7fac7"
        struct linkKeys {
            static let query = "q"
            static let page = "page"
            static let key = "key"
        }
        struct resultKey{
            static let recipe = "recipes"
            static let title = "title"
            static let sourceURL = "source_url"
            static let publisher = "publisher_url"
            static let imageURL = "image_url"
        }
    }
    
   /* curl --get --include 'https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/extract?forceExtraction=false&url=http%3A%2F%2Fallrecipes.com%2FRecipe%2FSlow-Cooker-Chicken-Tortilla-Soup%2FDetail.aspx' \
    -H 'X-Mashape-Key: DCrlBqI7Xjmsh1CsLRHWWDX89z5rp1EvsE6jsnjkh5Nnc7Vow6'*/
    
    struct mashape{
        static let link = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/extract"
        static let apiKeyHeader = "X-Mashape-Key"
        static let apiKey = "DCrlBqI7Xjmsh1CsLRHWWDX89z5rp1EvsE6jsnjkh5Nnc7Vow6"
        static let serverLink = "http://mrkking.com/badman/php/Mashape.php"
        struct linkKeys{
            static let forceExtraction = "forceExtraction"
            static let url = "link"
        }
        struct resultsKey{
            static let vegan = "vegan"
            static let prepMin = "preparationMinutes"
            static let cookMin = "cookingMinutes"
            static let servings = "servings"
            static let title = "title"
            static let inglist = "extendedIngredients"
            struct ingredients {
                static let amount = "amount"
                static let name = "originalString"
                static let image = "image"
                static let aisle = "aisle"
            }
        }
    }
}
