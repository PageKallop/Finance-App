//
//  SelectedTransactionViewController.swift
//  Finance App
//
//  Created by Page Kallop on 7/29/21.
//

import UIKit
import CoreData

class SelectedTransactionViewController: UIViewController {
    
    // creates url object
    var url : URL?
    
    //array created from CoreData Entity
    var savedTransaction = [SaveTransaction]()
    
    //content to save to CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        //sets and adds UIElements to view
        view.backgroundColor = .systemBackground
        
        view.addSubview(stackView)
        stackViewConstraints()
        
        view.addSubview(checkImage)
        imageConstrain()
        
        view.addSubview(amountLabel)
        amountLabelConstraints()
        
        view.addSubview(noteField)
        noteFieldConstraint()
        
        
        //set navigation bar with title and action buttons
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 50, width: view.frame.size.width, height: 50))
        view.addSubview(navBar)
        navBar.barTintColor = UIColor(red: 0/255, green: 12/255, blue: 73.8/255, alpha: 1)
        navBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        let navItem = UINavigationItem(title: "Transaction Detail")
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(goBack))
        navItem.leftBarButtonItem = doneItem
        doneItem.tintColor = .white
        navBar.setItems([navItem], animated: false)
        
        //create tap gesture to dismiss keyboard when user taps on screen
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)
    }

    //dismisses viewcontroller
    @objc func goBack(){
        
        //create a new saved object to append to savedTransaction coredata
        let newItem = SaveTransaction(context: self.context)
       
        //checks if fields are empty before it saves
        if noteField.text != "" {
            newItem.desc = descLabel.text!
            newItem.note = noteField.text!
            self.savedTransaction.append(newItem)
            
            saveItems()
            dismiss(animated: true, completion: nil)
            

        } else{
            
            dismiss(animated: true, completion: nil)
        }
        
    }
    //saves item to coredata
    func saveItems() {
        
        do {
           try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
    }
    //dismisses keyboard
    @objc func dismissKeyboard() {
    
        view.endEditing(true)
    }
//MARK:- UI Constraints
    func stackViewConstraints() {
        
        stackView.addArrangedSubview(descLabel)
        stackView.addArrangedSubview(dateLabel)
        
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -555).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -200).isActive = true
    }
    
    func amountLabelConstraints() {
        
        amountLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        amountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 200).isActive = true
        amountLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -625).isActive = true
        amountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
    }
    
    func imageConstrain()  {
        
        checkImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 500).isActive = true
        checkImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        checkImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        checkImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
        
    
    }
    
    func noteFieldConstraint() {
        
        noteField.topAnchor.constraint(equalTo: view.topAnchor, constant: 350).isActive = true
        noteField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        noteField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        noteField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -400).isActive = true
     
        
    }
//MARK:- UIElements 
    let noteField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Add Note"
        textField.layer.cornerRadius = 8.0
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor( red: 211/255, green: 211/255, blue: 211/255, alpha: 1.0 ).cgColor
        return textField
    }()
    
    var stackView : UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let amountLabel : UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(15)
        return label
    }()
    
    let descLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let dateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = UIFont.italicSystemFont(ofSize: 10)
        return label
    }()
    
    var checkImage : UIImageView = {
          let image = UIImageView()
          image.contentMode = .scaleAspectFill
          image.clipsToBounds = true
          image.translatesAutoresizingMaskIntoConstraints = false
          return image
      }()

}
