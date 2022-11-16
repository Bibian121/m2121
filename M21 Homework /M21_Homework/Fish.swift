//
//  Fish.swift
//  M21_Homework
//
//  Created by Bandit on 13.04.2022.
//

import UIKit

class Fish {
    var fish: UIImageView
    var isFishCathed: Bool
    
    init (fish: UIImageView, isFishCathed: Bool) {
        self.fish = fish
        self.isFishCathed = false
    }
}
