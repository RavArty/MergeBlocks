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
            x: -Constants.CellSize.tileWidth * CGFloat(Constants.ArenaSize.numColumns) / 2, //- Constants.CellSize.tileWidth/2,
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


}
