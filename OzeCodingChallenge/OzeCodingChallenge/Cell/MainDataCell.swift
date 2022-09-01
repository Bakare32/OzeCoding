//
//  MainDataCell.swift
//  OzeCodingChallenge
//
//  Created by Bakare Waris on 31/08/2022.
//

import UIKit

class MainDataCell: UITableViewCell {

    static var identifier = "MainCollectionViewCellID"
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
//        imageView.backgroundColor = .blue
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.image = UIImage(named: "blacky")
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let name = UILabel()
        name.textColor =  .label
        name.numberOfLines = 1
        name.font = UIFont(name: "Helvetica", size: 16)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Title here"
        return name
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.backgroundColor = .blue
        cellConstraints()
    }
    
    func setupViews() {
        addSubview(userImageView)
        addSubview(titleLabel)
    }
    
    func cellConstraints() {
        setupViews()
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 10),
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            userImageView.heightAnchor.constraint(equalToConstant: 60),
            userImageView.widthAnchor.constraint(equalToConstant: 60),
//            userImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.60).isActive = true
        ])
        
//        titleLabel.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 150, leftConstant: 50, bottomConstant: 0, rightConstant: 0)
//
//        userImageView.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 8, leftConstant: 5, bottomConstant: 0, rightConstant: 5)
//        userImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.60).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
//
    func configure(with model: DataRealmModel) {
        if model.avatarName == "" {
            let theName = model.name

            userImageView.rounded()
            userImageView.setTransactionImage(string: "A", color: UIColor.getDashColor(digits: Int(2)), circular: true, stroke: false, fontSize: 13)
        }
        getData(from: (model.avatarName?.asUrl)!) { data, response, error in
                guard let data = data, error == nil else { return }
                // always update the UI from the main thread
                DispatchQueue.main.async() { [weak self] in
                    self?.userImageView.rounded()
                    self?.userImageView.image = UIImage(data: data)
                }
            }
        
        titleLabel.text = model.name

    }
    
}
