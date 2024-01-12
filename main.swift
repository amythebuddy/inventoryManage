//
//  main.swift
//  PracticeSwift
//
//  Created by StudentAM on 1/12/24.
//

import Foundation

let itemsWithPrices: [String : Double] = [
    "Cereal": 4.99,
    "Milk": 4.99,
    "Syrup": 3.99,
    "Cup": 2.99
]

func mainMenu(){
    print("Welcome to the grocery store! Let's us know when you are ready to order! (Enter the number to proceed)\n"
          + "1. Add item to cart \n"
          + "2. Remove item for cart \n"
          + "3. Check if item is in stock \n"
          + "4. Admin Menu \n"
          + "5. Checkout \n")
}



mainMenu()
