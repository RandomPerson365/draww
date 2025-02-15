//
//  Game.swift
//  Drawsaurus
//
//  Created by Shark on 2015-08-18.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import UIKit

class Game {
    var drawingPhase = [UIImage]()
    var guessingPhase = [String]()
    var gameSize = 3

    
    init(guess: String) {
        addGuess(guess)
    }
    
    func addGuess(guess: String) {
        if (guessingPhase.count < gameSize) {
            guessingPhase.append(guess)
            println("text added")
        } else {
            println("game is over; can't guess anymore")
        }
    }
    
}

class DrawingPhase: NSArray {
    
}

class GuessingPhase: NSArray {
    
}

