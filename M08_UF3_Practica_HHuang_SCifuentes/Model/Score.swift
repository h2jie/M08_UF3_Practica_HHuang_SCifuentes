//
//  Score.swift
//  M08_UF3_Practica_HHuang_SCifuentes
//
//  Created by Hangjie Huang on 2018/5/16.
//  Copyright © 2018年 Hangjie Huang. All rights reserved.
//

import Foundation

class Score: Codable, Comparable {
    let value: Int
    let date: Date

    init(value: Int, date: Date) {
        self.value = value
        self.date = date
    }
}


func ==(lhs: Score, rhs: Score) -> Bool {
    return lhs.value == rhs.value && lhs.date == rhs.date
}

func <(lhs: Score, rhs: Score) -> Bool {
    if (lhs.value == rhs.value) {
        return lhs.date.timeIntervalSinceReferenceDate < rhs.date.timeIntervalSinceReferenceDate
    } else {
        return lhs.value < rhs.value
    }
}
