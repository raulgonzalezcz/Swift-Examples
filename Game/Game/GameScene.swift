//
//  GameScene.swift
//  Game
//
//  Created by UDLAP on 2/8/18.
//  Copyright © 2018 151211. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        var puki : SKSpriteNode
        var pukiAnimation:SKAction
        var pukiSequence:SKAction
        
        var wumpus:SKSpriteNode
        var wumpusAnimation:SKAction
        var wumpusSequence:SKAction
        
        self.anchorPoint = CGPoint.zero
        self.backgroundColor = UIColor(red:10/255, green:10/255, blue:10/255, alpha:1.0)
        
        puki = SKSpriteNode(imageNamed: "pukiRight")
        puki.size = CGSize(width:60, height:60)
        puki.position = CGPoint(x:350, y:250)
        //Adds node to child nodes
        self.addChild(puki)
        
        pukiAnimation = getRepetitionAction("pukiRight.png","pukiFlyingRight.png", 0.3)
        puki.run(pukiAnimation)
        
        wumpus = SKSpriteNode(imageNamed: "wumpusRight")
        wumpus.size = CGSize(width:80, height:80)
        wumpus.position = CGPoint(x:450, y:50)
        //Adds node to child nodes
        self.addChild(wumpus)
        
        wumpusAnimation = getRepetitionAction("wumpusRight.png","wumpusWalkingRight.png", 0.3)
        wumpus.run(wumpusAnimation)
        
        pukiSequence = SKAction.sequence([turnWest(), goWest(100), goSouthWest(150), turnEast(), goNorth(100)])
        puki.run(pukiSequence)
        
        wumpusSequence = SKAction.sequence([turnWest(), goWest(300), turnEast(), goEast(300)])
        wumpus.run(wumpusSequence)
    }
    
    func goNorth(_ units: Int)->SKAction{
        var theDuration : Int
        theDuration = units/20 //Se mueve 20 puntos
        return SKAction.moveBy(x: 0, y: CGFloat(units), duration: TimeInterval(theDuration))
    }
    
    func goNorthEast(_ units: Int)->SKAction{
        var theDuration : Int
        theDuration = units/20 //Se mueve 20 puntos
        return SKAction.moveBy(x: CGFloat(units), y: CGFloat(units), duration: TimeInterval(theDuration))
    }
    
    func goNorthWest(_ units: Int)->SKAction{
        var theDuration : Int
        theDuration = units/20 //Se mueve 20 puntos
        return SKAction.moveBy(x: -CGFloat(units), y: CGFloat(units), duration: TimeInterval(theDuration))
    }
    
    func goSouth(_ units: Int)->SKAction{
        var theDuration : Int
        theDuration = units/20 //Se mueve 20 puntos
        return SKAction.moveBy(x: 0, y: -CGFloat(units), duration: TimeInterval(theDuration))
    }
    
    func goSouthEast(_ units: Int)->SKAction{
        var theDuration : Int
        theDuration = units/20 //Se mueve 20 puntos
        return SKAction.moveBy(x: CGFloat(units), y: -CGFloat(units), duration: TimeInterval(theDuration))
    }
    
    func goSouthWest(_ units: Int)->SKAction{
        var theDuration : Int
        theDuration = units/20 //Se mueve 20 puntos
        return SKAction.moveBy(x: -CGFloat(units), y: -CGFloat(units), duration: TimeInterval(theDuration))
    }
    
    func goEast(_ units: Int)->SKAction{
        var theDuration : Int
        theDuration = units/20 //Se mueve 20 puntos
        return SKAction.moveBy(x: CGFloat(units), y: 0, duration: TimeInterval(theDuration))
    }
    
    func goWest(_ units: Int)->SKAction{
        var theDuration : Int
        theDuration = units/20 //Se mueve 20 puntos
        return SKAction.moveBy(x: -CGFloat(units), y: 0, duration: TimeInterval(theDuration))
    }
    
    func turnWest() ->SKAction{
        return SKAction.scaleX(to: -1, duration: 1)
    }
    
    func turnEast() ->SKAction{
        return SKAction.scaleX(to: 1, duration: 1)
    }
    
    func getRepetitionAction(_ imageNowName: String, _ imageThenName: String,_ secondsPerFrame: Double)-> SKAction{
        var imageNow:UIImage
        var imageThen:UIImage
        var textureAtlas:SKTextureAtlas
        var frames : [SKTexture]
        var animationAction : SKAction
        var repetitionAction : SKAction
        var imageNowID : String
        var imagenThenID : String
        var index : String.Index
        
        imageNow = UIImage(named:imageNowName)!
        imageThen = UIImage(named:imageThenName)!
        index = imageNowName.index(of: ".")!
        imageNowID = imageNowName.substring(to: index)
        index = imageThenName.index(of: ".")!
        imagenThenID = imageThenName.substring(to: index)
        textureAtlas = SKTextureAtlas(dictionary: [imageNowID : imageNow, imagenThenID : imageThen])
        frames = [textureAtlas.textureNamed(imageNowID), textureAtlas.textureNamed(imagenThenID)]
        animationAction = SKAction.animate(with: frames, timePerFrame: secondsPerFrame)
        repetitionAction = SKAction.repeatForever(animationAction)
        return repetitionAction
    }
    
}
