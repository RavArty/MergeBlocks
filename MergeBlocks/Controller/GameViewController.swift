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
//----------------------------------------------------------------------------------
    // MARK: Handle falling box
    func handleFalling(_ column: Int){
        view.isUserInteractionEnabled = false
        numberOfBox += 1
        
        let (boxNew, newRow) = level.fallBox(column: column)
        scene.animateFallingBox(box: boxNew, column: column, row: newRow){
            self.gameOverCheck()
            if self.numberOfBox == Constants.GrowAfterBoxNumber.boxNumber{
                self.boxesUp()
            }else{
                self.handleMatches()
            }
        }

    }
//----------------------------------------------------------------------------------
    func boxesUp(){
        let boxes = level.boxesUp()
        scene.animateBoxesUp(boxes: boxes){
            //     self.view.isUserInteractionEnabled = true
            self.handleMatches()
        }
        let newBoxes = level.addLowBoxes()
        scene.addSprites(for: newBoxes)
        numberOfBox = 0
        gameOverCheck()
        //   handleMatches()
    }
    //----------------------------------------------------------------------------------
    func handleMatches() {
        if !isGameOver{
            self.view.isUserInteractionEnabled = true
            let chains = level.removeMatches()
            if chains.count == 0 {
     //           let specialBoxesChain = level.checkSpecialBoxes()
     //           scene.animateSpecialBoxes(for: specialBoxesChain){
     //               let columns = self.level.fillHoles()
     //               self.scene.animateFallingBoxes(in: columns) {
                        self.shuffle()
     //               }
     //           }
                
                
                return
            }
            self.view.isUserInteractionEnabled = false
        scene.animateMatchedBoxes(for: chains) {
                for chain in chains{
                    let box = chain.firstBox()
                    //     let box = self.level.changeColor(chain.firstBox())
                    self.scene.changeColor(box)
                }
                let columns = self.level.fillHoles()
                self.scene.animateFallingBoxes(in: columns) {
                    //    self.view.isUserInteractionEnabled = true
                    self.handleMatches()
                    //self.handleMatches()
                }
            }
            
        }
    }
    //----------------------------------------------------------------------------------
    func updateLabels() {
        //        scoreLabel.text = String(format: "%ld", score)
    }
    //----------------------------------------------------------------------------------
    func gameOverCheck(){
        if level.checkLastLine(){
            self.view.isUserInteractionEnabled = true
            isGameOver = true
            gameOver()
        }
    }
//----------------------------------------------------------------------------------
    func gameOver(){
        let alertController = UIAlertController(title: "Game Over", message:
            "Restart the game", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Restart", style: .default, handler: {
            action in self.beginGame()
        }))
        
        
        self.present(alertController, animated: true)
    }
//----------------------------------------------------------------------------------
override var shouldAutorotate: Bool {
    return false
}

override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    if UIDevice.current.userInterfaceIdiom == .phone {
        return .allButUpsideDown
    } else {
        return .all
    }
}

override var prefersStatusBarHidden: Bool {
    return true
}

}
