//
//  Round.swift
//  DaWord Test
//
//  Created by Ahmad Adnan Abdullah on 2020-12-10.
//

import Foundation

struct Round{
    var HumanList : Question?
    var AnimalList : Question?
    var CitiesList : Question?
    
    let letter : [String] = ["A", "B", "C","D", "E", "F","G", "H", "I", "J", "K", "L","M", "N", "O", "P", "Q","R", "S", "T","U", "V","W","X","Y","Z"]
    var usedWord : [String] = []
    var points : Int = 0
    var category : Int = 0
    var letterNumber : Int = 0
    var count = 40
    var savedTimer : Timer?
    var finalName = ""
    var finalAnswer = ""
    var location = ""
}
