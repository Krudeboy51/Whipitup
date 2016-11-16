//
//  RecipeModel.swift
//  Whip it up
//
//  Created by user119166 on 11/14/16.
//  Copyright © 2016 Kory E King. All rights reserved.
//

import Foundation
import UIKit

class RecipeModel{
    var vegan = false
    var prepMin = 0
    var cookmin = 0
    var title = ""
    var servings = 0
    var instructions = ""
    
    struct extendedIngredients {
        var info = ""
        var name = ""
        var image = ""
        var aisle = ""
        init(aisle: String, image: String, name: String, info: String) {
            self.info = info
            self.name = name
            self.image = image
            self.aisle = aisle
        }
    }
    var ingredients = [extendedIngredients]()
    
    func addIngredient(aisle: String, image: String, name: String, info: String){
        let recipeIng = extendedIngredients.init(aisle: aisle, image: image, name: name, info: info)
        ingredients.append(recipeIng)
    }
}
