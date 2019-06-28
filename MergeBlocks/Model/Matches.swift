//
//  Matches.swift
//  MergeBlocks
//
//  Created by Ravshan on 6/11/19.
//  Copyright © 2019 ravkart. All rights reserved.
//


import Foundation

//MARK: Detect all matches
class Matches{
    
    var shape = Shapes()
    private var boxes = Array2D<Box>(columns: Constants.ArenaSize.numColumns, rows: Constants.ArenaSize.numRows)
    
    
    
    func detectMatches(_ boxes: Array2D<Box>) -> Set<Chain> {
        var set: Set<Chain> = []
        
        for row in 0..<Constants.ArenaSize.numRows - 2 {
            var column = 0
            while column < Constants.ArenaSize.numColumns {
                if let box = boxes[column, row] {
                    // let matchType = box.boxType
                    let resultShape = shape.findShape(box, boxes)
                    
                    switch resultShape{
                    case Constants.Shapes.ShapeType.horizontal2.rawValue:
                        let chain = Chain(chainType: .horizontal2)
                        
                        boxes[column,row]!.isInChain = true
                        boxes[column + 1,row]!.isInChain = true
                        if box.didFall{
                            chain.add(box: boxes[column, row]!)
                            chain.add(box: boxes[column + 1, row]!)
                        }else{
                            chain.add(box: boxes[column + 1, row]!)
                            chain.add(box: boxes[column, row]!)
                        }
                        // box.didFall = false
                        set.insert(chain)
                        
                    case Constants.Shapes.ShapeType.threehorizon.rawValue:
                        let chain = Chain(chainType: .threehorizon)
                        
                        boxes[column,row]!.isInChain = true
                        boxes[column + 1,row]!.isInChain = true
                        boxes[column + 2,row]!.isInChain = true
                        
                        chain.add(box: boxes[column + 1, row]!)
                        chain.add(box: boxes[column, row]!)
                        chain.add(box: boxes[column + 2, row]!)
                        set.insert(chain)
                        
                    case Constants.Shapes.ShapeType.vertical.rawValue:
                        let chain = Chain(chainType: .vertical)
                        
                        boxes[column,row]!.isInChain = true
                        boxes[column,row + 1]!.isInChain = true
                        chain.add(box: boxes[column, row]!)
                        chain.add(box: boxes[column, row + 1]!)
                        set.insert(chain)
                        
                    case Constants.Shapes.ShapeType.vertical3.rawValue:
                        let chain = Chain(chainType: .vertical3)
                        
                        boxes[column,row]!.isInChain = true
                        boxes[column,row + 1]!.isInChain = true
                        boxes[column,row + 2]!.isInChain = true
                        chain.add(box: boxes[column, row + 1]!)
                        chain.add(box: boxes[column, row]!)
                        chain.add(box: boxes[column, row + 2]!)
                        set.insert(chain)
                        
                    case Constants.Shapes.ShapeType.leftL.rawValue:
                        let chain = Chain(chainType: .leftL)
                        
                        boxes[column,row]!.isInChain = true
                        boxes[column + 1,row]!.isInChain = true
                        boxes[column + 1,row + 1]!.isInChain = true
                        chain.add(box: boxes[column + 1, row]!)
                        chain.add(box: boxes[column, row]!)
                        chain.add(box: boxes[column + 1, row + 1]!)
                        set.insert(chain)
                        
                    case Constants.Shapes.ShapeType.rightL.rawValue:
                        let chain = Chain(chainType: .rightL)
                        
                        boxes[column,row]!.isInChain = true
                        boxes[column + 1,row]!.isInChain = true
                        boxes[column,row + 1]!.isInChain = true
                        chain.add(box: boxes[column, row]!)
                        chain.add(box: boxes[column + 1, row]!)
                        chain.add(box: boxes[column, row + 1]!)
                        set.insert(chain)
                        
                    case Constants.Shapes.ShapeType.upsideDownLeftL.rawValue:
                        let chain = Chain(chainType: .upsideDownLeftL)
                        
                        boxes[column,row]!.isInChain = true
                        boxes[column,row + 1]!.isInChain = true
                        boxes[column - 1,row + 1]!.isInChain = true
                        chain.add(box: boxes[column, row + 1]!)
                        chain.add(box: boxes[column, row]!)
                        chain.add(box: boxes[column - 1, row + 1]!)
                        set.insert(chain)
                        
                    case Constants.Shapes.ShapeType.upsideDownRightL.rawValue:
                        let chain = Chain(chainType: .upsideDownRightL)
                        
                        boxes[column,row]!.isInChain = true
                        boxes[column + 1,row + 1]!.isInChain = true
                        boxes[column,row + 1]!.isInChain = true
                        chain.add(box: boxes[column, row + 1]!)
                        chain.add(box: boxes[column + 1, row + 1]!)
                        chain.add(box: boxes[column, row]!)
                        set.insert(chain)
                        
                    case Constants.Shapes.ShapeType.Thorizontal.rawValue:
                        let chain = Chain(chainType: .thorizon)
                        
                        boxes[column,row]!.isInChain = true
                        boxes[column,row + 1]!.isInChain = true
                        boxes[column - 1,row + 1]!.isInChain = true
                        boxes[column + 1,row + 1]!.isInChain = true
                        chain.add(box: boxes[column, row + 1]!)
                        chain.add(box: boxes[column, row]!)
                        chain.add(box: boxes[column - 1, row + 1]!)
                        chain.add(box: boxes[column + 1, row + 1]!)
                        set.insert(chain)
                        
                    case Constants.Shapes.ShapeType.TLeft.rawValue:
                        let chain = Chain(chainType: .tLeft)
                        
                        boxes[column,row]!.isInChain = true
                        boxes[column,row + 1]!.isInChain = true
                        boxes[column,row + 2]!.isInChain = true
                        boxes[column - 1,row + 1]!.isInChain = true
                        
                        chain.add(box: boxes[column, row + 1]!)
                        chain.add(box: boxes[column, row]!)
                        chain.add(box: boxes[column, row + 2]!)
                        chain.add(box: boxes[column - 1, row + 1]!)
                        set.insert(chain)
                        
                    case Constants.Shapes.ShapeType.TRight.rawValue:
                        let chain = Chain(chainType: .tRight)
                        
                        boxes[column,row]!.isInChain = true
                        boxes[column,row + 1]!.isInChain = true
                        boxes[column,row + 2]!.isInChain = true
                        boxes[column + 1,row + 1]!.isInChain = true
                        
                        chain.add(box: boxes[column, row + 1]!)
                        chain.add(box: boxes[column, row]!)
                        chain.add(box: boxes[column, row + 2]!)
                        chain.add(box: boxes[column + 1, row + 1]!)
                        set.insert(chain)
                        
                    case Constants.Shapes.ShapeType.TUpsideDown.rawValue:
                        let chain = Chain(chainType: .tUpsideDown)
                        
                        boxes[column,row]!.isInChain = true
                        boxes[column + 1,row]!.isInChain = true
                        boxes[column + 2,row]!.isInChain = true
                        boxes[column + 1,row + 1]!.isInChain = true
                        
                        chain.add(box: boxes[column + 1, row]!)
                        chain.add(box: boxes[column, row]!)
                        chain.add(box: boxes[column + 2, row]!)
                        chain.add(box: boxes[column + 1, row + 1]!)
                        set.insert(chain)
                        
                    default: ()
                        
                    }
                    //    set = shape.changeType(in: set)
                    
                }
                
                column += 1
            }
            
            
        }
        return set
    }
    
}
