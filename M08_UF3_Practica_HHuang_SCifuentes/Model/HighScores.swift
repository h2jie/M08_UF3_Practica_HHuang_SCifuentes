//
//  HighScores.swift
//  M08_UF3_Practica_HHuang_SCifuentes
//
//  Created by Hangjie Huang on 2018/5/16.
//  Copyright © 2018年 Hangjie Huang. All rights reserved.
//

import Foundation

class HighScores:Codable{
    var theScores:[Score]

    init(){
        self.theScores=[Score]()
    }

    func addScore(newScore:Score) {
        theScores.append(newScore)
        theScores.sort(){$0>$1}
        while(theScores.count>10){
            theScores.remove(at: 10)
        }
    }
}