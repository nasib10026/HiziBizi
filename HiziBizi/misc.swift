//
//  misc.swift
//  HiziBizi
//
//  Created by Rakibul Nasib on 27/11/23.
//

import Foundation

let everydayObjects = [
    "pen", "paper", "keyboard", "mouse", "chair", "table", "lamp", "clock", "book", "phone",
    "wallet", "glasses", "shoes", "socks", "headphones", "umbrella", "mirror", "brush", "toothbrush", "toothpaste",
    "towel", "plate", "fork", "knife", "spoon", "cup", "plate", "bowl", "pot", "pan",
    "refrigerator", "oven", "microwave", "trash can", "broom", "dustpan", "mop", "bucket", "dish rack", "dish soap",
    "sponge", "washer", "dryer", "bed", "pillow", "blanket", "alarm clock", "calendar", "camera", "remote control",
    "charger", "candle", "vase", "key", "wallet", "sunscreen", "notebook", "pencil", "scissors", "tape", "stapler",
    "calculator","guitar", "television", "radio", "teapot", "coffeemaker", "cutting board", "tongs", "oven mitts", "safety pins", "thread",
    "needle", "thread spool", "screwdriver", "pliers", "hammer", "nail", "tape measure", "ruler", "flashlight", "battery",
    "extension cord", "power strip", "fan", "air freshener", "pencil sharpener", "sticky notes", "keyboard tray", "magnifying glass",
    "extension ladder", "flash drive", "USB cable", "external hard drive", "sunglasses", "sun hat", "sunscreen", "lip balm", "water bottle",
    "backpack", "wallet", "tissue box", "hand sanitizer", "umbrella", "raincoat", "snow shovel", "gloves", "scarf", "hat"
]

enum PlayerAuthState: String

{
    case authenticating = "Logging in to Game Center..."
    case unauthenticated = "Please sign in to Game Center to play."
    case authenticated = ""
    
    case error = "There was an error logging into Game Center"
    case restricted = "You're not allowed to play multiplayer games!"
    
}

struct PastGuess: Hashable {
    let message: String
    let correct: Bool

    init(message: String, correct: Bool) {
        self.message = message
        self.correct = correct
    }


}

let maxTimeRemaining = 100
