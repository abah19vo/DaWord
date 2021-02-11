//
//  Qustions.swift
//  DaWord Test
//
//  Created by Ahmad Adnan Abdullah on 2020-11-18.
//

import Foundation

struct Question: Decodable {
    
 //   var letters: [Int : String] = ["A", "B", "C","D", "E", "F","G", "H", "I", "J", "K", "L","M", "N", "O", "P", "Q","R", "S", "T","U", "V","W", "X", "Y", "Z"]
 //   var category: [Int : String] = [1:"Human",2:"Animal",3:"Movie"]
    
    let A : [String]
    let B : [String]
    let C : [String]
    let D : [String]
    let E : [String]
    let F : [String]
    let G : [String]
    let H : [String]
    let I : [String]
    let J : [String]
    let K : [String]
    let L : [String]
    let M : [String]
    let N : [String]
    let O : [String]
    let P : [String]
    let Q : [String]
    let R : [String]
    let S : [String]
    let T : [String]
    let U : [String]
    let V : [String]
    let W : [String]
    let X : [String]
    let Y : [String]
    let Z : [String]
    
    
    
}

protocol PropertyReflectable { }

extension PropertyReflectable {
    subscript(key: String) -> Any? {
        let m = Mirror(reflecting: self)
        return m.children.first { $0.label == key }?.value
    }
}

extension Question : PropertyReflectable {}



