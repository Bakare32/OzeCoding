//
//  DetailsViewController.swift
//  OzeCodingChallenge
//
//  Created by Bakare Waris on 01/09/2022.
//

import UIKit

class DetailsViewController: UIViewController {

    var avatarId = ""
    var name = ""
    
    let productImageV: UIImageView = {
      let view = UIImageView()
      view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.97, alpha: 1.00)
//      view.contentMode = .scaleAspectFit
      view.layer.cornerRadius = 20
      view.isUserInteractionEnabled = true
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "User Details"
        navigationController?.navigationBar.prefersLargeTitles =  true
        setupConstraints()
        
        productPriceTextView.text = "Name: \(name)"
        getImage()
        // Do any additional setup after loading the view.
    }
    
    
    @objc func didTapTopBackArrowButton() {
//      navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func addDefaultViews() {
      view.addSubview(productImageV)
      view.addSubview(productPriceTextView)
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func getImage() {
        getData(from: (avatarId.asUrl)!) { data, response, error in
                guard let data = data, error == nil else { return }
                // always update the UI from the main thread
                DispatchQueue.main.async() { [weak self] in
//                    self?.productImageV.rounded()
                    self?.productImageV.image = UIImage(data: data)
                }
            }
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
      ])
    }
    
    

}
