//
//  TransactionTableViewCell.swift
//  Finance App
//
//  Created by Page Kallop on 7/29/21.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //adds UIElements to view
        self.contentView.backgroundColor = .secondarySystemBackground
        addSubview(stackView)
        addSubview(amountLabel)
        stackViewConstraints()
        amountConstraint()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //configures cell with with transactionModel objects
    func configureCell(with transactionModel: TransactionModel) {
       
        //formats date
        let timeStamp  = transactionModel.dateTransaction
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: timeStamp)
       
        
        let tempLocale = dateFormatter.locale
        
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = tempLocale
        let dateString = dateFormatter.string(from: date!)

        //sets text with data
        descLabel.text = transactionModel.descTransaction
        dateLabel.text = "\(dateString)"
        amountLabel.text = "$\(transactionModel.amountTransaction)"
        
        //checks if is isCredit is true or false and changes text color
        if transactionModel.creditTransaction == true {
            amountLabel.textColor = UIColor(red: 0/255, green: 110/255, blue: 51/255, alpha: 1)

        }else {
            amountLabel.textColor = UIColor.red
        }
        
    }
//MARK:- UI Constraints
    func stackViewConstraints() {
        
        stackView.addArrangedSubview(descLabel)
        stackView.addArrangedSubview(dateLabel)
        
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -200).isActive = true
    }
    
    func amountConstraint() {
        amountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        amountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 285).isActive = true
        amountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant:  -20).isActive = true
    }
    

    
//MARK:- UIElements 
    var stackView : UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
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
        label.numberOfLines = 0
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
    
    
}
