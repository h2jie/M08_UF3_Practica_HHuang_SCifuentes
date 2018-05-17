//
//  Game.swift
//  M08_UF3_Practica_HHuang_SCifuentes
//
//  Created by Hangjie Huang on 2018/5/8.
//  Copyright © 2018年 Hangjie Huang. All rights reserved.
//

import Foundation
class Game: Codable{
   
    static let filePath = "game.gd"
    let couples:[String] = ["cat","dog","pig","snake","mouse","lion","tiger","camel","panda","bear","wolf","horse","cow","shark","crab","duck","octopus","fish"]
    var items:[String]
    var rowsCount:Int
    var colsCount:Int
    var score:Int
    var remainingTurns:Int
    var matchesCount:Int = 0
    
    init(rows:Int, cols:Int) {
        self.score = 0;
        self.remainingTurns=36
        self.rowsCount = rows
        self.colsCount = cols
        self.items = [String]()
        
        
        
        
        while items.count < 40 {
//            for _ in 0..<self.rowsCount{
//                for _ in 0..<self.colsCount{
                    let random = Int(arc4random()%18)
                    if !containsTwo(element: couples[random]){
                        items.append(couples[random])
//                    }
//                }
            }
        }
 
        
    }
    
    func matches () -> Bool {
        if self.matchesCount == 18 {
            return false
        }
        return true
    }
    
    func addMatch(){
        self.matchesCount += 1
    }
    
    func increasingTurns(){
        self.remainingTurns+=1
    }
    
    func decreasingTurns(){
        self.remainingTurns-=1
    }
    
    func increasingScore(){
        self.score+=5
    }
    
    func decreasingScore(){
        self.score-=2
    }
    
    func containsTwo(element:String) -> Bool{
        var count:Int = 0
        
        for item in self.items{
            if item == element{
                count+=1
                if (count==2){return true}
            }
        }
        return false
    }
    
    static func fileNamePath() -> String?{
        let fileManager = FileManager()
        if let dirDocument = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first{
            let gameData = dirDocument.appendingPathComponent(self.filePath)
            return gameData.path
        }
        return nil
    }
    
}
