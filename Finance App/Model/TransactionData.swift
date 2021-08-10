//
//  TransactionData.swift
//  Finance App
//
//  Created by Page Kallop on 7/29/21.
//

import Foundation

struct TransactionData: Codable {
    var transactions : [transactions]
}

struct transactions: Codable {
    
    var id : Int
    var date : String
    var amount : Double
    var isCredit : Bool
    var description : String
    var imageUrl : String?
}
