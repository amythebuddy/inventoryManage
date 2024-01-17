
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
enum Action {
    case add, remove
}
let itemNames = ["", "cereal", "milk", "syrup", "cup"]
var totalPrice = 0.0
var roundedPrice = 0.0
var itemName = ""
var loopingMainMenu = true
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
        // check the userInput as integer to continue else tell user to input 1 to 6
        if let user = readLine(){
            switch user {
                case "1": // add an item to the user cart
                    processAddOrRemove(action: .add)
                case "2": // remove an item from the user cart
                    processAddOrRemove(action: .remove)
                case "3":
                    checkingItemsInStock()
                case "4":
                    //get all of the purchased items to add back to the stock
                    itemsInStock = [
                        "cereal": itemsInStock["cereal"]! + userCart["cereal"]!,
                        "milk": itemsInStock["milk"]! + userCart["milk"]!,
                        "syrup": itemsInStock["syrup"]! + userCart["syrup"]!,
                        "cup": itemsInStock["cup"]! + userCart["cup"]!
                    ]
                    // removed all items from the user cart
                    userCart = [
                        "cereal": 0,
                        "milk": 0,
                        "syrup": 0,
                        "cup": 0
                    ]
                    //reset the price back to 0
                    roundedPrice = 0.0
                    print("Removed all items from your cart!")
                case "5":
                    print("Enter Admin ID: ")
                    if let enteredPassword = readLine(), enteredPassword == password { // if the password is correct, go to the admin menu
                        showAdminMenu()
                    } else {
                        print("The ID is not correct.")
                    }
                case "6":
                    let grandTotal = roundedPrice + (roundedPrice * 0.925) // get the grand total after % 9.25 tax
                    let roundedGrandTotal = (grandTotal * 100).rounded() / 100 // round the grand total after tax
                    // a list of purchased items with the amount
                    print("Thanks for shopping with us! \n"
                        + "You purchases the following: \n"
                        + "Cereal(s): \(userCart["cereal"]!) \n"
                        + "Milk: \(userCart["milk"]!) \n"
                        + "Syrup: \(userCart["syrup"]!) \n"
                        + "Cup(s): \(userCart["cup"]!) \n"
                        + "Your grand total including tax (9.25%) is: $\(roundedGrandTotal)")
                    loopingMainMenu = false // stop the loop
                default:
                    print("Please enter a valid option!") // any options beside 1 to 6 will print this line
            }
        }
    }
}
func getItemInput() -> String? {
    //if the user input something outside of 1 to the length of itemNames return nil
    guard let item = readLine(), let itemInput = Int(item), itemInput > 0, itemInput < itemNames.count else {
        print("Please enter a valid option!")
        return nil
    }
    itemName = itemNames[itemInput] //get the item from the number that user choose
    return itemName
}
func processAddOrRemove(action: Action){
    print("What would you like to \(action) in the cart? Enter number of selection \n"
          + "1. Cereal \n"
          + "2. Milk \n"
          + "3. Syrup \n"
          + "4. Cup")
    //check the input from 1 to 4 else print a line tell user enter 1 to 4
    guard let selectedOption = getItemInput() else { return }
    print("How many \(selectedOption)(s) would you like to \(action) in your cart? \n")
    guard let amount = readLine(), let amountInt = Int(amount) else { // check if they input a number or a word
        print("Please type in a number.")
        return
    }
    switch action {
        case .add:
            //check if the input is less than itemsInStock
            if amountInt < itemsInStock[selectedOption]! {
                print("You have added \(amountInt) \(selectedOption)(s) to your cart!")
                // calculate the stock again after purchasing
                itemsInStock[selectedOption]! -= amountInt
                //add the items to user cart
                userCart[selectedOption]! += amountInt
                //calculate the price after the user add the item in the cart
                totalPrice += Double(amountInt) * itemsWithPrices[selectedOption]!
            } else {
                print("Your amount exceed our items in stock.")
            }
        case .remove:
            //check if the input is less or equal than the purchased items
            if amountInt <= userCart[selectedOption]! {
                print("You have removed \(amountInt) \(selectedOption)(s) to your cart!")
                // calculate the stock again after removing item
                itemsInStock[selectedOption]! += amountInt
                //add the items to user cart
                userCart[selectedOption]! -= amountInt
                //calculate the price after the user remove the item in the cart
                totalPrice -= Double(amountInt) * itemsWithPrices[selectedOption]!
            } else {
                print("Your cart does not have that amount of \(selectedOption)s to remove.")
            }
    }
    //round the price to 2 decimal
    roundedPrice = (totalPrice * 100).rounded() / 100
    print("Current total is: $\(roundedPrice)")
}

func checkingItemsInStock(){
    print("What item would you like to check if it's in stock? Enter number of selection \n"
          + "1. Cereal \n"
          + "2. Milk \n"
          + "3. Syrup \n"
          + "4. Cup")
    guard let selectedOption = getItemInput() else { return } // check the input
    print("There are currently \(itemsInStock[selectedOption]!) \(selectedOption)s")
}

func showAdminMenu(){
    var loopingAdminMenu = true // for the admin menu to keep running even when coming back for the second time
    while loopingAdminMenu {
        print("Welcome to the Admin menu! Lets us know how we can help you (Enter number of selection): \n"
              + "1. Restock inventory \n"
              + "2. Generate report \n"
              + "3. Check number of items \n"
              + "4. Quit admin menu")
        if let user = readLine() {
            switch user {
                case "1":
                    print("What would you like to restock? (Enter number of selection): \n"
                          + "1. Cereal \n"
                          + "2. Milk \n"
                          + "3. Syrup \n"
                          + "4. Cup")
                guard let selectedOption = getItemInput() else { return }
                    print("How many units of \(selectedOption) would you like to restock? ")
                    if let restock = readLine(), let restockItem = Int(restock) { // input the amount to restock
                        itemsInStock[selectedOption]! += restockItem // the selectedItem will get restocked
                        print("Restocked \(restockItem) units of cup")
                    }
                    
                case "2":
                    //get the sum of all items
                    let remainingStock = itemsInStock["cereal"]! + itemsInStock["milk"]! + itemsInStock["syrup"]! + itemsInStock["cup"]!
                    print("Summary report: \n"
                          + "Remaining cereals: \(itemsInStock["cereal"]!) \n"
                          + "Remaining milk: \(itemsInStock["milk"]!) \n"
                          + "Remaining syrup: \(itemsInStock["syrup"]!) \n"
                          + "Remaining cups: \(itemsInStock["cup"]!) \n"
                          + "Remaining Inventory: \(remainingStock) \n"
                          + "Total sales: $\(roundedPrice)")
                case "3":
                    checkingItemsInStock()
                case "4":
                    loopingAdminMenu = false
                    print("Returning to normal menu")
                    return
                default:
                    print("Please enter a valid option!") // any options beside 1 to 4 will print this line
            }
        }
    }
}

showMainMenu()
