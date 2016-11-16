//
//  MCONSTANTS.swift
//  curl
//
//  Created by Kory E King on 11/11/16.
//  Copyright © 2016 Kory E King. All rights reserved.
//

import Foundation

class mCONSTANTS {


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
            static let query = "q"
            static let id = "id"
        }
        struct resultsKey{
            static let results = "results"
            static let id = "id"
            static let readyMin = "readyInMinutes"
            static let vegan = "vegan"
            static let prepMin = "preparationMinutes"
            static let cookMin = "cookingMinutes"
            static let servings = "servings"
            static let title = "title"
            static let inglist = "extendedIngredients"
            static let image = "image"
            static let baseURI = "baseUri" //"https://spoonacular.com/recipeImages/"
            struct ingredients {
                static let amount = "amount"
                static let name = "originalString"
                static let image = "image"
                static let aisle = "aisle"
            }
        }
    }
}
