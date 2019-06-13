//
//  Shapes.swift
//  MergeBlocks
//
//  Created by Ravshan on 6/12/19.
//  Copyright © 2019 ravkart. All rights reserved.
//

import Foundation

class Shapes{
    
    private var boxes = Array2D<Box>(columns: Constants.ArenaSize.numColumns, rows: Constants.ArenaSize.numRows)
    
    
    
    
    func findShape(_ box: Box, _ boxes: Array2D<Box>) -> String{
        var shapeType: String = ""
        let initColumn = box.column
        let initRow = box.row
        
        //Horizontal 2
        if initColumn < Constants.ArenaSize.numColumns - 1{
            if let _ = boxes[initColumn + 1, initRow]{
                if boxes[initColumn + 1, initRow]?.boxType == box.boxType && !boxes[initColumn,initRow]!.isInChain && !boxes[initColumn + 1,initRow]!.isInChain{
                    
                    shapeType = Constants.Shapes.ShapeType.horizontal2.rawValue
                }
            }
        }
        
        //Horizontal 3
        if initColumn < Constants.ArenaSize.numColumns - 2 {
            if let _ = boxes[initColumn + 1, initRow], let _ = boxes[initColumn + 2, initRow]{
                if boxes[initColumn + 1, initRow]?.boxType == box.boxType &&
                    boxes[initColumn + 2, initRow]?.boxType == box.boxType && !boxes[initColumn,initRow]!.isInChain && !boxes[initColumn + 1,initRow]!.isInChain && !boxes[initColumn + 2,initRow]!.isInChain{
                    
                    shapeType = Constants.Shapes.ShapeType.threehorizon.rawValue
                }
            }
        }
        
        //Vertical 2
        if initRow < Constants.ArenaSize.numRows - 3 {
            if let _ = boxes[initColumn, initRow + 1]{
                if boxes[initColumn, initRow + 1]!.boxType == box.boxType && !boxes[initColumn,initRow]!.isInChain && !boxes[initColumn, initRow + 1]!.isInChain{
                    
                    shapeType = Constants.Shapes.ShapeType.vertical.rawValue
                }
            }
        }
        
        //Vertical 3
        if initRow < Constants.ArenaSize.numRows - 4 {
            if let _ = boxes[initColumn, initRow + 1], let _ = boxes[initColumn, initRow + 2]{
                if boxes[initColumn, initRow + 1]!.boxType == box.boxType && boxes[initColumn, initRow + 2]!.boxType == box.boxType && !boxes[initColumn,initRow]!.isInChain && !boxes[initColumn, initRow + 1]!.isInChain && !boxes[initColumn, initRow + 2]!.isInChain{
                    
                    shapeType = Constants.Shapes.ShapeType.vertical3.rawValue
                }
            }
        }
        
        //Left L shape
        if initColumn < Constants.ArenaSize.numColumns - 1 && initRow > 0 {
            if let _ = boxes[initColumn + 1, initRow], let _ = boxes[initColumn + 1, initRow + 1]{
                if boxes[initColumn + 1, initRow]?.boxType == box.boxType &&
                    boxes[initColumn + 1, initRow + 1]?.boxType == box.boxType &&
                    !boxes[initColumn, initRow]!.isInChain &&
                    !boxes[initColumn + 1, initRow]!.isInChain &&
                    !boxes[initColumn + 1, initRow + 1]!.isInChain{
                    
                    shapeType = Constants.Shapes.ShapeType.leftL.rawValue
                }
            }
        }
        
        //Right L shape
        if initColumn < Constants.ArenaSize.numColumns - 1 && initRow > 0 {
            if let _ = boxes[initColumn + 1, initRow], let _ = boxes[initColumn, initRow + 1]{
                if boxes[initColumn + 1, initRow]?.boxType == box.boxType &&
                    boxes[initColumn, initRow + 1]?.boxType == box.boxType &&
                    !boxes[initColumn,initRow]!.isInChain &&
                    !boxes[initColumn + 1,initRow]!.isInChain &&
                    !boxes[initColumn,initRow + 1]!.isInChain{
                    
                    shapeType = Constants.Shapes.ShapeType.rightL.rawValue
                }
            }
        }
        
        //Upside down left L shape
        if initColumn > 0 && initRow < Constants.ArenaSize.numRows - 3{
            if let _ = boxes[initColumn, initRow + 1], let _ = boxes[initColumn - 1, initRow + 1]{
                if  boxes[initColumn, initRow + 1]?.boxType == box.boxType &&
                    boxes[initColumn - 1, initRow + 1]?.boxType == box.boxType &&
                    !boxes[initColumn,initRow]!.isInChain &&
                    !boxes[initColumn,initRow + 1]!.isInChain &&
                    !boxes[initColumn - 1,initRow + 1]!.isInChain{
                    
                    shapeType = Constants.Shapes.ShapeType.upsideDownLeftL.rawValue
                }
            }
        }
        
        //Upside down right L shape
        if initColumn < Constants.ArenaSize.numColumns - 1 && initRow < Constants.ArenaSize.numRows - 3{
            if let _ = boxes[initColumn, initRow + 1], let _ = boxes[initColumn + 1, initRow + 1]{
                if boxes[initColumn, initRow + 1]?.boxType == box.boxType &&
                    boxes[initColumn + 1, initRow + 1]?.boxType == box.boxType &&
                    !boxes[initColumn, initRow]!.isInChain &&
                    !boxes[initColumn,initRow + 1]!.isInChain &&
                    !boxes[initColumn + 1, initRow + 1]!.isInChain{
                    
                    shapeType = Constants.Shapes.ShapeType.upsideDownRightL.rawValue
                }
            }
        }
        //T shape
        if initColumn > 0 && initColumn < Constants.ArenaSize.numColumns - 1 && initRow < Constants.ArenaSize.numRows - 3{
            if let _ = boxes[initColumn, initRow + 1], let _ = boxes[initColumn - 1, initRow + 1], let _ = boxes[initColumn + 1, initRow + 1]{
                if boxes[initColumn, initRow + 1]?.boxType == box.boxType &&
                    boxes[initColumn - 1, initRow + 1]?.boxType == box.boxType &&
                    boxes[initColumn + 1, initRow + 1]?.boxType == box.boxType &&
                    !boxes[initColumn, initRow]!.isInChain &&
                    !boxes[initColumn, initRow + 1]!.isInChain &&
                    !boxes[initColumn - 1,initRow + 1]!.isInChain &&
                    !boxes[initColumn + 1, initRow + 1]!.isInChain{
                    
                    shapeType = Constants.Shapes.ShapeType.Thorizontal.rawValue
                }
            }
        }
        //T Left shape
        if initColumn > 0 && initRow < Constants.ArenaSize.numRows - 4{
            if let _ = boxes[initColumn + 1, initRow], let _ = boxes[initColumn + 2, initRow], let _ = boxes[initColumn + 1, initRow + 1]{
                if boxes[initColumn + 1, initRow]?.boxType == box.boxType &&
                    boxes[initColumn + 2, initRow]?.boxType == box.boxType &&
                    boxes[initColumn + 1, initRow + 1]?.boxType == box.boxType &&
                    !boxes[initColumn, initRow]!.isInChain &&
                    !boxes[initColumn + 1, initRow]!.isInChain &&
                    !boxes[initColumn + 2, initRow]!.isInChain &&
                    !boxes[initColumn + 1,initRow + 1]!.isInChain{
                    
                    shapeType = Constants.Shapes.ShapeType.TUpsideDown.rawValue
                }
            }
        }
        
        //T Right shape
        if initColumn < Constants.ArenaSize.numColumns - 1 && initRow < Constants.ArenaSize.numRows - 4{
            if let _ = boxes[initColumn, initRow + 1], let _ = boxes[initColumn, initRow + 2], let _ = boxes[initColumn + 1, initRow + 1]{
                if boxes[initColumn, initRow + 1]?.boxType == box.boxType &&
                    boxes[initColumn, initRow + 2]?.boxType == box.boxType &&
                    boxes[initColumn + 1, initRow + 1]?.boxType == box.boxType &&
                    !boxes[initColumn, initRow]!.isInChain &&
                    !boxes[initColumn, initRow + 1]!.isInChain &&
                    !boxes[initColumn, initRow + 2]!.isInChain &&
                    !boxes[initColumn + 1,initRow + 1]!.isInChain{
                    
                    shapeType = Constants.Shapes.ShapeType.TRight.rawValue
                }
            }
        }
        
        //T Upside Down shape
        if  initColumn < Constants.ArenaSize.numColumns - 2 && initRow < Constants.ArenaSize.numRows - 3{
            if let _ = boxes[initColumn, initRow + 1], let _ = boxes[initColumn, initRow + 2], let _ = boxes[initColumn + 1, initRow + 1]{
                if boxes[initColumn, initRow + 1]?.boxType == box.boxType &&
                    boxes[initColumn, initRow + 2]?.boxType == box.boxType &&
                    boxes[initColumn + 1, initRow + 1]?.boxType == box.boxType &&
                    !boxes[initColumn, initRow]!.isInChain &&
                    !boxes[initColumn, initRow + 1]!.isInChain &&
                    !boxes[initColumn, initRow + 2]!.isInChain &&
                    !boxes[initColumn + 1,initRow + 1]!.isInChain{
                    
                    shapeType = Constants.Shapes.ShapeType.TRight.rawValue
                }
            }
        }
        
        //Quadro shape
        if initColumn > 0 && initColumn < Constants.ArenaSize.numColumns - 2 && initRow < Constants.ArenaSize.numRows - 4{
            if let _ = boxes[initColumn + 1, initRow + 1], let _ = boxes[initColumn, initRow + 2], let _ = boxes[initColumn + 1, initRow + 1]{
                if boxes[initColumn, initRow + 1]?.boxType == box.boxType &&
                    boxes[initColumn, initRow + 2]?.boxType == box.boxType &&
                    boxes[initColumn + 1, initRow + 1]?.boxType == box.boxType &&
                    !boxes[initColumn, initRow]!.isInChain &&
                    !boxes[initColumn, initRow + 1]!.isInChain &&
                    !boxes[initColumn, initRow + 2]!.isInChain &&
                    !boxes[initColumn + 1,initRow + 1]!.isInChain{
                    
                    shapeType = Constants.Shapes.ShapeType.TRight.rawValue
                }
            }
        }
        
        return shapeType
    }
    
    
    
    
}
