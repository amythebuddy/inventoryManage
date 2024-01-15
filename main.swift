
//
//  main.swift
//  PracticeSwift
//
//  Created by StudentAM on 1/12/24.
//

import Foundation

let itemsWithPrices: [String : Double] = [
    "cereal": 4.99,
    "milk": 4.99,
    "syrup": 3.99,
    "cup": 2.99
]
var itemsInStock: [String: Int] = [
    "cereal": 100,
    "milk": 100,
    "syrup": 100,
    "cup": 100
]

var userCart: [String : Int] = [
    "cereal": 0,
    "milk": 0,
    "syrup": 0,
    "cup": 0
]

let itemNames = ["", "cereal", "milk", "syrup", "cup"]
var totalPrice = 0.0
var roundedPrice = 0.0
var itemName = ""
var loopingMainMenu = true
var loopingAdminMenu = true
let password = "1111"

func showMainMenu(){
    while loopingMainMenu {
        print("Welcome to the grocery store! Let's us know when you are ready to order! (Enter the number to proceed)\n"
              + "1. Add item to cart \n"
              + "2. Remove an item for cart \n"
              + "3. Check if item is in stock \n"
              + "4. Remove all items from the cart \n"
              + "5. Admin Menu \n"
              + "6. Checkout")
        //allow user to enter input
        guard let user = readLine() else {
            return
        }
        
        // check the userInput as integer to continue else tell user to input 1 to 6
        if let userInput = Int(user), userInput > 0, userInput < 7 {
            switch userInput {
            case 1, 2: // add or remove case
                
                //If userInput is equal to 1, assign the value 'add' to the action variable; otherwise, assign the value 'remove'.
                let action = (userInput == 1) ? "add" : "remove"
                print("What would you like to \(action) to the cart? Enter number of selection \n"
                      + "1. Cereal \n"
                      + "2. Milk \n"
                      + "3. Syrup \n"
                      + "4. Cup \n")
                //check the input from 1 to 4 else print a line tell user enter 1 to 4
                if let item = readLine(), let itemInput = Int(item), itemInput > 0, itemInput < itemNames.count {
                    itemName = itemNames[itemInput]
                    
                    print("How many \(itemName)(s) would you like to \(action) in your cart? \n")
                    guard let amount = readLine(), let amountInt = Int(amount) else {
                        print("Please type in a number.")
                        return
                    }
                    
                    
                    switch action {
                        case "add":
                            if amountInt < itemsInStock[itemName]! {
                                print("You have added \(amountInt) \(itemName)(s) to your cart!")
                                // calculate the stock again after purchasing
                                itemsInStock[itemName]! -= amountInt
                                
                                //add the items to user cart
                                userCart[itemName]! += amountInt
                                
                                //calculate the price after the user add the item in the cart
                                totalPrice += Double(amountInt) * itemsWithPrices[itemName]!
                                
                                //round the price to 2 decimal
                                roundedPrice = (totalPrice * 100).rounded() / 100
                                print("Current total is: $\(roundedPrice) \n")
                            } else {
                                print("Your amount exceed our items in stock.")
                            }
                        case "remove":
                            if amountInt <= userCart[itemName]! {
                                print("You have removed \(amountInt) \(itemName)(s) to your cart!")
                                
                                itemsInStock[itemName]! += amountInt
                                
                                userCart[itemName]! -= amountInt
                                
                                totalPrice -= Double(amountInt) * itemsWithPrices[itemName]!
                                roundedPrice = (totalPrice * 100).rounded() / 100
                                print("Current total is: $\(roundedPrice)")
                            }
                            else {
                                print("Your cart does not have that amount of \(itemName)s to remove.")
                            }
                        default:
                            print("Out of action")
                    }
                } else {
                       print("Please enter a number from 1 to 4")
                       return
                }
        
            case 3:
                checkingItemsInStock()
            case 4:
                userCart = [
                    "cereal": 0,
                    "milk": 0,
                    "syrup": 0,
                    "cup": 0
                ]
                totalPrice = 0.0
                print("Removed all items from your cart!")
            case 5:
                print("Enter Admin ID: ")
                if let enteredPassword = readLine(), enteredPassword == password {
                    showAdminMenu()
                } else {
                    print("The ID is not correct.")
                }
            case 6:
                let grandTotal = roundedPrice * 0.925
                let roundedGrandTotal = (grandTotal * 100).rounded() / 100
                print("Thanks for shopping with us! \n"
                    + "You purchases the following: \n"
                    + "Cereal(s): \(userCart["cereal"]!) \n"
                    + "Milk: \(userCart["milk"]!) \n"
                    + "Syrup: \(userCart["syrup"]!) \n"
                    + "Cup(s): \(userCart["cup"]!) \n"
                    + "Your grand total including tax (9.25%) is: $\(roundedGrandTotal)")
                loopingMainMenu = false
            default:
                print("Please enter a number from 1 to 4!")
            }
        } else {
            print("Please enter a number from 1 to 6!")
        }
    }
}

func showAdminMenu(){
    while loopingAdminMenu {
        print("Welcome to the Admin menu! Lets us know how we can help you (Enter number of selection): \n"
              + "1. Restock inventory \n"
              + "2. Generate report \n"
              + "3. Check number of items \n"
              + "4. Quit admin menu")
        guard let user = readLine(), let userInput = Int(user), userInput > 0, userInput < 5 else {
            print("Please enter from 1 to 4")
            return
        }
        switch userInput {
        case 1:
            print("What would you like to restock? (Enter number of selection): \n"
                  + "1. Cereal \n"
                  + "2. Milk \n"
                  + "3. Syrup \n"
                  + "4. Cup")
            if let item = readLine(), let itemInput = Int(item), itemInput > 0, itemInput < itemNames.count {
                    itemName = itemNames[itemInput]
                    print("How many units of \(itemName) would you like to restock? ")
                    if let restock = readLine(), let restockItem = Int(restock) {
                        itemsInStock[itemName]! += restockItem
                        print("Restocked \(restockItem) units of cup")
                    }
            } else {
                print("Please enter a number from 1 to 4")
            }
        case 2:
            let remainingStock = itemsInStock["cereal"]! + itemsInStock["milk"]! + itemsInStock["syrup"]! + itemsInStock["cup"]!
            print("Summary report: \n"
                  + "Remaining cereals: \(itemsInStock["cereal"]!) \n"
                  + "Remaining milk: \(itemsInStock["milk"]!) \n"
                  + "Remaining syrup: \(itemsInStock["syrup"]!) \n"
                  + "Remaining cups: \(itemsInStock["cup"]!) \n"
                  + "Remaining Inventory: \(remainingStock) \n"
                  + "Total sales: \(roundedPrice)")
        case 3:
            checkingItemsInStock()
        case 4:
            print("Returning to normal menu")
            return
        default:
            print("Please enter a number from 1 to 4!")
        }
    }
}
func checkingItemsInStock(){
    print("What item would you like to check if it's in stock? Enter number of selection \n"
          + "1. Cereal \n"
          + "2. Milk \n"
          + "3. Syrup \n"
          + "4. Cup")
    guard let item = readLine(), let itemInput = Int(item), itemInput > 0, itemInput < itemNames.count else {
        print("Please enter 1 to 4")
        return
    }
    itemName = itemNames[itemInput]
    print("There are currently \(itemsInStock[itemName]!) \(itemName)s")
}

showMainMenu()

