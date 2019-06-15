//
//  GameScene.swift
//  MergeBlocks
//
//  Created by Ravshan on 6/3/19.
//  Copyright © 2019 ravkart. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var level: Level!
    
    let gameLayer = SKNode()
    let boxesLayer = SKNode()
    
    let tilesLayer = SKNode()
    let cropLayer = SKCropNode()
    let maskLayer = SKNode()
    
    var tapHandler: ((_ column: Int) -> Void)?
    
    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addChild(gameLayer)
        
        let layerPosition = CGPoint(
            // MARK: on IPhoneX too close to right edge, substract tileWidth/2
            x: -Constants.CellSize.tileWidth * CGFloat(Constants.ArenaSize.numColumns) / 2 - Constants.CellSize.tileWidth/2,
            y: -Constants.CellSize.tileHeight * CGFloat(Constants.ArenaSize.numRows) / 2)
        
        
        boxesLayer.position = layerPosition
        tilesLayer.position = layerPosition
        maskLayer.position = layerPosition
        cropLayer.maskNode = maskLayer
        gameLayer.addChild(tilesLayer)
        gameLayer.addChild(cropLayer)
        cropLayer.addChild(boxesLayer)
        //   gameLayer.addChild(boxesLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//----------------------------------------------------------------------------------
    // MARK: converts (column, row) -> Point
    func pointFor(column: Int, row: Int) -> CGPoint {
        return CGPoint(
            x: CGFloat(column) * Constants.CellSize.tileWidth + Constants.CellSize.tileWidth / 2,
            y: CGFloat(row) * Constants.CellSize.tileHeight + Constants.CellSize.tileHeight / 2)
    }
//----------------------------------------------------------------------------------
    // MARK: converts Point -> (column, row)
    func convertPoint(_ point: CGPoint) -> (column: Int, row: Int) {
        if point.x >= 0 && point.x <= (CGFloat(Constants.ArenaSize.numColumns) * Constants.CellSize.tileWidth + Constants.CellSize.tileWidth / 2) &&
            point.y >= 0 && point.y <= (CGFloat(Constants.ArenaSize.numRows) * Constants.CellSize.tileHeight + Constants.CellSize.tileWidth / 2) {
            return (Int(point.x / Constants.CellSize.tileWidth), Int(point.y / Constants.CellSize.tileHeight))
        } else {
            return (0, 0)  // invalid location
        }
    }
//----------------------------------------------------------------------------------
    //MARK: Removes all boxes from board
    func removeAllBoxSprites() {
        boxesLayer.removeAllChildren()
    }
//----------------------------------------------------------------------------------
    // MARK: add sprite to a swinging box
    func addSprite(for box: Box) {
        
        let sprite = SKShapeNode()
        sprite.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Constants.CellSize.tileWidth, height: Constants.CellSize.tileHeight), cornerRadius: 5).cgPath
         sprite.fillColor = box.boxType.spriteName
         sprite.strokeColor = UIColor.black
         sprite.lineWidth = 2
         sprite.position = pointFor(column: box.column, row: box.row)
         sprite.zPosition = 1
        
        //   print("sprite.pos1: \(sprite.position.x), \(sprite.position.y)")
        boxesLayer.addChild(sprite)
        box.boxSprite = sprite
    }
//----------------------------------------------------------------------------------
    // MARK: add sprites to growing boxes from bottom
    func addSprites(for boxes: Set<Box>) {
        for box in boxes{
            
            let sprite = SKShapeNode()
            sprite.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: Constants.CellSize.tileWidth, height: Constants.CellSize.tileHeight), cornerRadius: 5).cgPath
            sprite.fillColor = box.boxType.spriteName
            sprite.strokeColor = UIColor.black
            sprite.lineWidth = 2
            sprite.position = pointFor(column: box.column, row: box.row)
            sprite.zPosition = 1
            box.boxSprite = sprite
            boxesLayer.addChild(sprite)
        }
    }
//----------------------------------------------------------------------------------
    //MARK: Adding tiles
    func addTiles() {
        // 1
        for row in 0...Constants.ArenaSize.numRows {
            for column in 0...Constants.ArenaSize.numColumns {
                //           if level.tileAt(column: column, row: row) != nil {
                let tileNode = SKSpriteNode(imageNamed: "MaskTile")
                tileNode.size = CGSize(width: Constants.CellSize.tileWidth, height: Constants.CellSize.tileHeight)
                tileNode.position = pointFor(column: column, row: row)
                maskLayer.addChild(tileNode)
                //           }
            }
        }
        
        for row in 0..<Constants.ArenaSize.numRows - 1 {
            for column in 0..<Constants.ArenaSize.numColumns {
                //      if level.tileAt(column: column, row: row) != nil {
                let tileNode = SKShapeNode()
                tileNode.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: Constants.CellSize.tileWidth, height: Constants.CellSize.tileHeight)).cgPath
                //     tileNode.fillColor = .gray
                tileNode.strokeColor = .white
                tileNode.alpha = 0.1
                tileNode.lineWidth = 1
                var point = pointFor(column: column, row: row)
            //    point.x -= Constants.CellSize.tileWidth / 2
            //    point.y -= Constants.CellSize.tileHeight / 2
                tileNode.position = point
                
                tilesLayer.addChild(tileNode)
                //       }
            }
        }
    }
//----------------------------------------------------------------------------------
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        findClosestCell()
    }
    
    func findClosestCell(){
        let box = level.box(atColumn: 0, row: Constants.ArenaSize.numRows - 1)
        let sprite = box!.boxSprite!
        let newBoxColumn = convertPoint(sprite.position).column
        
        if let handler = tapHandler {
            handler(newBoxColumn)
        }
    }
//----------------------------------------------------------------------------------
    // MARK: Animate falling box
    func animateFallingBox(box: Box, column: Int, row: Int, completion: @escaping () -> Void){
        let sprite = box.boxSprite
        sprite!.removeAction(forKey: "swingBox")
        //move box to closest cell
        let newPosition = pointFor(column: column, row: Constants.ArenaSize.numRows - 1)
        let duration = 0.1
        // print("sprite.pos: \(sprite!.position.x), \(sprite!.position.y)")
        // print("newPosition: \(newPosition.x), \(newPosition.y)"
        let moveAction = SKAction.move(to: newPosition, duration: duration)
        
        var longestDuration: TimeInterval = 0
        //animate falling box
        let newPosition2 = pointFor(column: column, row: row)
        let duration2 = TimeInterval(((sprite!.position.y - newPosition2.y) / Constants.CellSize.tileHeight) * 0.05)
        longestDuration = max(longestDuration, (duration + duration2))
        let moveAction2 = SKAction.move(to: newPosition2, duration: duration2)
        moveAction2.timingMode = .easeOut
        
        sprite!.run(SKAction.sequence([moveAction, moveAction2]))
        run(SKAction.wait(forDuration: longestDuration), completion: completion)
    }
//----------------------------------------------------------------------------------
    // MARK: Animate moving boxes up
    func animateBoxesUp(boxes: [Box], completion: @escaping () -> Void){
        var duration: TimeInterval = 0
        for box in boxes{
            let newPosition = pointFor(column: box.column, row: box.row)
            let sprite = box.boxSprite
            duration = TimeInterval(((newPosition.y - sprite!.position.y) / Constants.CellSize.tileHeight) * 0.1)
            let moveAction = SKAction.move(to: newPosition, duration: duration)
            //    moveAction.timingMode = .easeOut
            box.boxSprite!.run(SKAction.group([moveAction]), withKey: "moveUp")
        }
        run(SKAction.wait(forDuration: duration), completion: completion)
    }
//----------------------------------------------------------------------------------
    // MARK: Animated merging boxes
    func animateMatchedBoxes(for chains: Set<Chain>, completion: @escaping () -> Void) {
        var firstBox: Box = Box(column: 0, row: 0, boxType: .unknown, isInChain: false)
        for chain in chains {
            for box in chain.boxes{
                if box == chain.firstBox(){firstBox = box}
            }
            for box in chain.boxes {
                if box.isNeedToDestr{
                    if let sprite = box.boxSprite {
                        if sprite.action(forKey: "removing") == nil {
                            let scaleAction = SKAction.scale(to: 0.1, duration: 0.3)
                            
                            scaleAction.timingMode = .easeOut
                            sprite.run(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                       withKey: "removing")
                        }
                    }
                }else{
                    if box != chain.firstBox(){
                        
                        if let sprite = box.boxSprite {
                            sprite.zPosition = -1
                            if sprite.action(forKey: "removing") == nil {
                                let moveTo = SKAction.move(to: pointFor(column: firstBox.column, row: firstBox.row), duration: 0.3)
                                let scaleAction = SKAction.fadeOut(withDuration: 0.3)
                                
                                scaleAction.timingMode = .easeOut
                                sprite.run(SKAction.sequence([moveTo, scaleAction, SKAction.removeFromParent()]),
                                           withKey: "removing")
                            }
                        }
                    }
                }
                
            }
        }
        run(SKAction.wait(forDuration: 0.6), completion: completion)
    }
//----------------------------------------------------------------------------------
    // MARK: Animated special boxes
    func animateSpecialBoxes(for chains: Set<Chain>, completion: @escaping () -> Void) {
        //  var firstBox: Box = Box(column: 0, row: 0, boxType: .unknown, isInChain: false)
        for chain in chains {
            for box in chain.boxes {
                if box.isNeedToDestr{
                    if let sprite = box.boxSprite {
                        if sprite.action(forKey: "removing") == nil {
                            let scaleAction = SKAction.scale(to: 0.1, duration: 0.3)
                            
                            scaleAction.timingMode = .easeOut
                            sprite.run(SKAction.sequence([scaleAction, SKAction.removeFromParent()]),
                                       withKey: "removing")
                        }
                    }
                    
                }
                
            }
        }
        run(SKAction.wait(forDuration: 0.3), completion: completion)
    }
//----------------------------------------------------------------------------------
    // MARK: Animate falling boxes after matching
    func animateFallingBoxes(in columns: [[Box]], completion: @escaping () -> Void) {
        
        var longestDuration: TimeInterval = 0
        for array in columns {
            for (index, box) in array.enumerated() {
                let newPosition = pointFor(column: box.column, row: box.row)
                //  let delay = 0.0
                let delay = 0.1 * TimeInterval(index)
                //  let delay = 0.05 + 0.15 * TimeInterval(index)
                let sprite = box.boxSprite!   // sprite always exists at this point
                let duration = TimeInterval(((sprite.position.y - newPosition.y) / Constants.CellSize.tileHeight) * 0.1)
                longestDuration = max(longestDuration, duration + delay)
                let moveAction = SKAction.move(to: newPosition, duration: duration)
                moveAction.timingMode = .easeOut
                sprite.run(
                    SKAction.sequence([
                        SKAction.wait(forDuration: delay),
                        SKAction.group([moveAction])]))
            }
        }
        
        run(SKAction.wait(forDuration: longestDuration), completion: completion)
    }
//----------------------------------------------------------------------------------
    // MARK: Animate top swinging box
    func animateSwingBox(box: Box){
        let newBox = box.boxSprite!
        let oldPosition = pointFor(column: box.column, row: box.row)
        let newPosition = pointFor(column: Constants.ArenaSize.numColumns - 1, row: Constants.ArenaSize.numRows - 1)
        let moveAction1 = SKAction.move(to: newPosition, duration: 2)
        moveAction1.timingMode = .easeOut
        let delay = 0.1
        let moveAction2 = SKAction.move(to: oldPosition, duration: 2)
        moveAction2.timingMode = .easeOut
        //    newBox.run(SKAction.repeatForever(SKAction.sequence([moveAction1, moveAction2])), withKey: "swingBox")
        
        newBox.run(SKAction.repeatForever(SKAction.sequence([moveAction1, SKAction.wait(forDuration: delay), moveAction2, SKAction.wait(forDuration: delay)])), withKey: "swingBox")
        
        
    }
//----------------------------------------------------------------------------------
    // MARK: Change color after merging
    func changeColor(_ box: Box){
        if let sprite = box.boxSprite{
            sprite.fillColor = box.boxType.spriteName
            
        }
    }
//----------------------------------------------------------------------------------
    // MARK: Stop swinging animation
    func stopSwinging(){
        
    }


}
