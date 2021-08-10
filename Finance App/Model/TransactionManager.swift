//
//  TransactionManager.swift
//  Finance App
//
//  Created by Page Kallop on 7/29/21.
//

import Foundation


class TransactionManager {
    
    //creates singleton
   static let shared = TransactionManager()
    //creates url string
    let urlString = URL(string: "https://m1-technical-assessment-data.netlify.app/transactions-v1.json")
    
    init(){}
    //makes an HTTP Get request to get data from api 
    func getTransaction(completion: @escaping (Result<[transactions], Error>) -> Void) {
      
        guard let url  = urlString else {
 
            return
            }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
         
            }
            else if let data = data {
          
                do {
                    let result = try JSONDecoder().decode(TransactionData.self, from: data)
    
                  print(result)
                    completion(.success(result.transactions))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
        
    }
    
}
