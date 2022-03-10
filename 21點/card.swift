//
//  card.swift
//  21點
//
//  Created by 黃靖蜜 on 2022/2/20.
//

import Foundation

struct Card{
    var suit:String
    var rank:String
    var number:Int{
        if self.rank == "A"{
            return 11
        }else if self.rank == "J" {
            return 10
        }else if self.rank == "Q" {
            return 10
        }else if self.rank == "K" {
            return 10
        }else{
            return Int(self.rank)!
        }
    }
}
