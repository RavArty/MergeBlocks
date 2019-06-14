//
//  GameViewController.swift
//  MergeBlocks
//
//  Created by Ravshan on 6/3/19.
//  Copyright © 2019 ravkart. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var scene: GameScene!
    var level: Level!
    var numberOfBox = 0
    var score = 0
    var isGameOver = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        beginGame()
    }
    func setupScene(){
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        
        // Create and configure the scene.
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFit
        
        level = Level()
        scene.level = level
        scene.addTiles()
        scene.tapHandler = handleFalling
        skView.presentScene(scene)
    }
    
    func beginGame() {
        score = 0
        //  gameOver()
        numberOfBox = 0
        level.cleanArena()
        scene.removeAllBoxSprites()
        updateLabels()
        isGameOver = false
        shuffle()
    }
    
    func shuffle() {
        let newBox = level.newBox()
        scene.addSprite(for: newBox)
        scene.animateSwingBox(box: newBox)
    }
}
