//
//  Game.swift
//  M08_UF3_Practica_HHuang_SCifuentes
//
//  Created by Hangjie Huang on 2018/5/8.
//  Copyright © 2018年 Hangjie Huang. All rights reserved.
//

import Foundation
class Game{
   
    let couples:[String] = ["cat","dog","pig","snake","mouse","lion","tiger","camel","panda","bear","wolf","horse","cow","shark","crab","duck","octopus","fish"]
    var items:[String]
    var rowsCount:Int
    var colsCount:Int
    var score:Int
    var remainingTurns:Int
    
    init(rows:Int, cols:Int) {
        self.score = 0;
        self.remainingTurns=20
        self.rowsCount = rows
        self.colsCount = cols
        self.items = [String]()
        
        
        
        
        while items.count < 36 {
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
        self.score-=5
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
    
    
}
