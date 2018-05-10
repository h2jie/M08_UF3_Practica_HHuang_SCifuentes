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
        
        for _ in 0..<self.rowsCount{
            for _ in 0..<self.colsCount{
                let random = Int(arc4random()%18)
                if !containsTwo(array: items, element: couples[random]){
                    items.append(couples[random])
                }
            }
        }
        
        
    }
    
    func increasingScore(){
        self.score+=5
    }
    
    func decreasingScore(){
        self.score-=5
    }
    
    func containsTwo(array:[String], element:String) -> Bool{
        var count:Int = 0
        
        for item in array{
            if count >= 2 {
                return true
            }
            if item == element{
                count+=1
            }
        }
        return false
    }
    
    
}
