//
//  ViewController.swift
//  Finance App
//
//  Created by Page Kallop on 7/29/21.
//

import UIKit
import CoreData


class TransactionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //content to save to CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //array created from CoreData Entity
    var transactionModel = [TransactionModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0/255, green: 12/255, blue: 73.8/255, alpha: 1)
        
        //sets tableview and registers tableviewcell
        view.addSubview(tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 80
        tableViewConstraints()
        
        //set navigation bar with title and action buttons
        navigationItem.title = "Transactions"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
  
        let dateSort = UIBarButtonItem(title: "Search by date", style: .plain, target: self, action: #selector(dateSort))
        dateSort.tintColor = .white
        let totalSort = UIBarButtonItem(title: "Search by total", style: .plain, target: self, action: #selector(totalSort))
        totalSort.tintColor = .white
        navigationItem.rightBarButtonItems = [dateSort]
        navigationItem.leftBarButtonItems = [totalSort]
        //calls function to load json data
        callTransactions()
   
    }
  
    func callTransactions() {
        //calls funtion to get data a parses it
        TransactionManager.shared.getTransaction { [weak self] result in
            switch result {
            
            case .success(let transaction):
                
                self?.transactionModel = transaction.compactMap({ TransactionModel(userId: $0.id, dateTransaction: $0.date, amountTransaction: $0.amount, creditTransaction: $0.isCredit, descTransaction: $0.description, imageCheck: URL(string: $0.imageUrl ?? ""))
                    
                })
                //reloads tableview on main thread
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
    
        }
    }
    
    //bar button function to sort by date
    @objc func dateSort() {
        print("Tapped")
        
        
        transactionModel = transactionModel.sorted(by: { $0.dateTransaction > $1.dateTransaction })

        tableView.reloadData()
    }
    
    //bar button function to sort by total
    @objc func totalSort() {

        transactionModel = transactionModel.sorted(by: { $0.amountTransaction > $1.amountTransaction})

        tableView.reloadData()
    }
    
      //creates tableview
    let tableView : UITableView = {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //creates tableview constraints
    func tableViewConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
//MARK:- TableView Methods
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return rows for items in transactionModel array
        return transactionModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //sets custom cell fore reusable cell and configures it with transactionModel
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TransactionTableViewCell
        
        cell.configureCell(with: transactionModel[indexPath.row])
        
        return cell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //send data to detail view
        let openTransaction = transactionModel[indexPath.row]
        //creates segue to SelectedTransactionViewController
        let selectedTransaction = SelectedTransactionViewController()
        selectedTransaction.modalPresentationStyle = .fullScreen
        present(selectedTransaction, animated: true, completion: nil)
        
       
        selectedTransaction.descLabel.text = openTransaction.descTransaction
        selectedTransaction.amountLabel.text = "$\(openTransaction.amountTransaction)"
        
        //formats date
        let timeStamp  = openTransaction.dateTransaction
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: timeStamp)
        let tempLocale = dateFormatter.locale
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = tempLocale
        let dateString = dateFormatter.string(from: date!)
        
        selectedTransaction.dateLabel.text = "\(dateString)"
        
        //fetches saved notes from CoreData
        let request : NSFetchRequest<SaveTransaction> = SaveTransaction.fetchRequest()
        
        do {
            selectedTransaction.savedTransaction = try context.fetch(request)
            
        } catch {
            print("Error fetching from context\(error)")
        }
        //sorts through array of savedTransaction to load the correct note to transaction description
        for _ in selectedTransaction.savedTransaction {
            
            if transactionModel[indexPath.row].descTransaction ==  selectedTransaction.savedTransaction[indexPath.row].desc {
                selectedTransaction.noteField.text = selectedTransaction.savedTransaction[indexPath.row].note
           
            }
        }

        //gets image url
        if let data = openTransaction.imageData {
            selectedTransaction.checkImage.image = UIImage(data: data)
            print(data)
        }
        else if let url = openTransaction.imageCheck {
            print(url)
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else{
                    return
                }

                DispatchQueue.main.async {
                   selectedTransaction.url = url

                    selectedTransaction.checkImage.image = UIImage(data: data)
                }
            }
            .resume()
        }
        
    }
    
    
}


