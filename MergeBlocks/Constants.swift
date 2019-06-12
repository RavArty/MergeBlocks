//
//  Constants.swift
//  MergeBlocks
//
//  Created by Ravshan on 6/3/19.
//  Copyright © 2019 ravkart. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct CellSize {
        static let tileWidth: CGFloat = 39.0  //35.0
        static let tileHeight: CGFloat = 43.0 //39.0
    }
    
    struct ArenaSize{
        static let numColumns = 8
        static let numRows = 15
    }
    
    struct GrowAfterBoxNumber{
        static let boxNumber = 3
    }
    struct ColorAmount{
        //  static let quantity: UInt32 = 4
        static let quantity: UInt32 = 10
    }
    struct Shapes{
        enum ShapeType: String {
            case none = "none"
            case horizontal2 = "horizontal2"
            case horizontalAll = "horizontalAll"
            case vertical = "vertical"
            case verticalAll = "verticalAll"
            case vertical3 = "vertical3"
            case threehorizon = "threehorizon"
            case Thorizontal = "thorizontal"
            case TLeft = "TLeft"
            case TRight = "TRight"
            case TUpsideDown = "TUpsideDown"
            case rightL = "rightL"
            case leftL = "leftL"
            case upsideDownRightL = "upsideDownRightL"
            case upsideDownLeftL = "upsideDownLeftL"
            case triangleLowerLG = "triangleLowerLG"
            case triangleLowerRG = "triangleLowerRG"
            case Quadro = "quadro"
        }
    }
    
}
