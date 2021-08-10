//
//  TransactionModel.swift
//  Finance App
//
//  Created by Page Kallop on 7/29/21.
//

import Foundation

//creates and initializes a transaction model 
class TransactionModel {
    
    var userId : Int
    var dateTransaction : String
    var amountTransaction : Double
    var creditTransaction : Bool
    var descTransaction : String
    var imageCheck : URL?
    let imageData: Data? = nil
    
    init(
        
    userId : Int,
    dateTransaction : String,
    amountTransaction : Double,
    creditTransaction : Bool,
    descTransaction : String,
    imageCheck : URL?
    
    
    ) {
        self.userId = userId
        self.dateTransaction = dateTransaction
        self.amountTransaction = amountTransaction
        self.creditTransaction = creditTransaction
        self.descTransaction = descTransaction
        self.imageCheck = imageCheck
    }
}
