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
}
