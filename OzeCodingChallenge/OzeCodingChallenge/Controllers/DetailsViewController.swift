//
//  DetailsViewController.swift
//  OzeCodingChallenge
//
//  Created by Bakare Waris on 01/09/2022.
//

import UIKit

class DetailsViewController: UIViewController {

    
    let productImageV: UIImageView = {
      let view = UIImageView()
      view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.97, alpha: 1.00)
      view.contentMode = .scaleAspectFit
      view.layer.cornerRadius = 20
      view.isUserInteractionEnabled = true
        view.backgroundColor = .blue
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    let productPriceTextView: UILabel = {
      let textView = UILabel()
      textView.text = "Name: $111.67"
      textView.font = UIFont.boldSystemFont(ofSize: 14)
      textView.font = UIFont(name: "NunitoSans-Semibold", size: 14)
      textView.translatesAutoresizingMaskIntoConstraints = false
      return textView
    }()
    
    let idTextView: UILabel = {
      let textView = UILabel()
      textView.text = "Name: $111.67"
      textView.font = UIFont.boldSystemFont(ofSize: 14)
      textView.font = UIFont(name: "NunitoSans-Semibold", size: 14)
      textView.translatesAutoresizingMaskIntoConstraints = false
      return textView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "User Details"
        navigationController?.navigationBar.prefersLargeTitles =  true
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    
    @objc func didTapTopBackArrowButton() {
//      navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func addDefaultViews() {
      view.addSubview(productImageV)
      view.addSubview(idTextView)
      view.addSubview(productPriceTextView)

    }
    
    func setupConstraints() {
      addDefaultViews()
      NSLayoutConstraint.activate([
        productImageV.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
        productImageV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        productImageV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        productImageV.heightAnchor.constraint(equalToConstant: 200),
        productPriceTextView.topAnchor.constraint(equalTo: productImageV.bottomAnchor, constant: 30),
        productPriceTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
        idTextView.topAnchor.constraint(equalTo: productPriceTextView.bottomAnchor, constant: 20),
        idTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      ])
    }
    
    

}
