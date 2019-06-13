//
//  Level.swift
//  MergeBlocks
//
//  Created by Ravshan on 6/3/19.
//  Copyright © 2019 ravkart. All rights reserved.
//

import Foundation
import SpriteKit

class Level{
    
    private var falledBox = Box(column: Constants.ArenaSize.numColumns - 1, row: Constants.ArenaSize.numRows - 1, boxType: .unknown, isInChain: false)
    private var boxes = Array2D<Box>(columns: Constants.ArenaSize.numColumns, rows: Constants.ArenaSize.numRows)
    
    var matches = Matches()
    var changeType = ChangeType()
    
//----------------------------------------------------------------------------------
    //MARK: Check availability of box
    func box(atColumn column: Int, row: Int) -> Box? {
        precondition(column >= 0 && column < Constants.ArenaSize.numColumns)
        precondition(row >= 0 && row < Constants.ArenaSize.numRows)
        return boxes[column, row]
    }
//----------------------------------------------------------------------------------
    // MARK: Initialize swinging box
    func newBox() -> Box{
        return newSwingBox()
    }
//----------------------------------------------------------------------------------
        //MARK: Create new swinging box on top of screen
        func newSwingBox() -> Box{
            
            var boxType: BoxType = .unknown
            var newBoxType: BoxType
            repeat{
                newBoxType = BoxType.random()
            }while newBoxType == boxType
            boxType = newBoxType
            let box = Box(column: 0, row: Constants.ArenaSize.numRows - 1, boxType: boxType, isInChain: false)
            box.didFall = true
            boxes[0,Constants.ArenaSize.numRows - 1] = box
            return box
        }
//----------------------------------------------------------------------------------
    // MARK: Clean arena
    func cleanArena(){
        for column in 0...(Constants.ArenaSize.numColumns - 1){
            for row in 0...(Constants.ArenaSize.numRows - 2){
                boxes[column,row] = nil
                boxes[column,row]?.boxSprite = nil
            }
        }
    }
//----------------------------------------------------------------------------------
    // MARK: Check boxes on the last line
    func checkLastLine() -> Bool{
        var isExist: Bool = false
        for column in 0...(Constants.ArenaSize.numColumns - 1){
            //   if boxes[column,3] != nil{
            if boxes[column,Constants.ArenaSize.numRows - 2] != nil{
                isExist = true
            }
        }
        return isExist
    }
//----------------------------------------------------------------------------------
    // MARK: Fall box after touch
    // Box stopped at "column", after func checks the lowest empty cell starting from lowest row
    func fallBox(column: Int) -> (Box, Int) {
        //initail position at [0, lastRow]
        let box = boxes[0, Constants.ArenaSize.numRows - 1]
        let oldColumn = column
        var newRow = 0
        for row in 0..<Constants.ArenaSize.numRows{
            if boxes[oldColumn,row] == nil{
                newRow = row
                boxes[0, Constants.ArenaSize.numRows - 1] = nil
                box?.column = oldColumn
                box?.row = row
                boxes[oldColumn,row] = box
                break
            }
        }
        falledBox = box!
        return (box! , newRow)
    }
//----------------------------------------------------------------------------------
    // MARK: Move all boxes up..new bottom line not instantiated yet
    func boxesUp() -> [Box] {
        var array = [Box]()
        
        for column in 0...(Constants.ArenaSize.numColumns - 1){
            for row in (0...(Constants.ArenaSize.numRows - 2)).reversed(){
                if let box = boxes[column, row]{
                    box.row = row + 1
                    boxes[column,row + 1] = box
                    boxes[column,row] = nil
                    array.append(box)
                }
            }
        }
        return array
    }
//----------------------------------------------------------------------------------
    //MARK: add new instantiated line of boxes to the lowest row
    func addLowBoxes() -> Set<Box> {
        var set: Set<Box> = []
        
        for column in 0..<Constants.ArenaSize.numColumns {
            var boxType: BoxType
            repeat {
                boxType = BoxType.random()
            } while column >= 1 &&
                boxes[column - 1, 0]?.boxType == boxType
            
            
            let box = Box(column: column, row: 0, boxType: boxType, isInChain: false)
            boxes[column, 0] = box
            
            set.insert(box)
        }
        
        return set
    }
//----------------------------------------------------------------------------------
    //MARK: Remove matches
    func removeMatches() -> Set<Chain> {
        
        let shapes = matches.detectMatches(boxes)
        boxes[falledBox.column, falledBox.row]?.didFall = false
        removeBoxes(in: shapes)
        
        return shapes
    }
//------------------------------------------------------------------------------------
    // MARK: Remove matched boxes
    private func removeBoxes(in chains: Set<Chain>) {
        
        for chain in chains {
            
            for box in chain.boxes {
                if box.isNeedToDestr{
                    boxes[box.column, box.row] = nil
                }else{
                    //we need to merge object into one..first in chain will always be there
                    //       chain.firstBox().boxType = changeType.changeType(chain.firstBox())
                    chain.firstBox().isInChain = false
                    if box != chain.firstBox(){
                        boxes[box.column, box.row] = nil
                    }
                }
            }
            
        }
    }
//------------------------------------------------------------------------------------
    // MARK: Change color
    func changeColor(_ box: Box) -> Box{
        box.boxType = changeType.changeType(box)
        return box
        
    }
    
}
