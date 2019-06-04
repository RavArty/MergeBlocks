//
//  Box.swift
//  MergeBlocks
//
//  Created by Ravshan on 6/3/19.
//  Copyright © 2019 ravkart. All rights reserved.
//

import Foundation
import SpriteKit

// MARK: - BoxType
enum BoxType: Int {
    // MARK: change
    //   case unknown = 0, green, blue, red, yellow, brown, cyan, magenta, purple, orange, white
    case unknown = 0, cookie, macaron, cupcake, donut, icecream, jelly, cake
    
    var spriteName: String {
        let spriteNames = [
            "cookie",
            "macaron",
            "cupcake",
            "donut",
            "ice_cream",
            "jelly",
            "cake"]
        
        return spriteNames[rawValue - 1]
    }
    
    static func random() -> BoxType {
        return BoxType(rawValue: Int(arc4random_uniform(Constants.ColorAmount.quantity)) + 1)!
        //   return BoxType(rawValue: Int(arc4random_uniform(4)) + 1)!
    }
}

// MARK: - Box ...CustomStringConvertible - commented for now
// as Box will be used in a Set, it's necessary for objects to conform Hashable protocol
class Box: Hashable {    //CustomStringConvertible,
    
    var column: Int
    var row: Int
    var boxType: BoxType
    var boxSprite: SKSpriteNode? //SKShapeNode?
    var isInChain: Bool = false
    //    var checked: Bool
    //var sprite: SKSpriteNode? - make it active in future
    
    init(column: Int, row: Int, boxType: BoxType, isInChain: Bool) {
        self.column = column
        self.row = row
        self.boxType = boxType
        self.isInChain = isInChain
        //      self.checked = false
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
    
    static func ==(lhs: Box, rhs: Box) -> Bool {
        return lhs.column == rhs.column && lhs.row == rhs.row
        
    }
    /* from - CustomStringConvertible
     var description: String {
     return "type:\(boxType) square:(\(column),\(row))"
     }
     */
    
}

