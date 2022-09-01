//
//  ViewController.swift
//  OzeCodingChallenge
//
//  Created by Bakare Waris on 30/08/2022.
//

import UIKit
import RealmSwift

var realmDB = try! Realm()



class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    let tableView = UITableView()
    
    var sectionTitles = [String]()
    
    var viewModel =  GetDataViewModel()
    
    var dataLoadLimit = 10
    var totalAlbums = 0
    var index = 0
    
    var dataToken: NotificationToken?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserverOnCategories()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .red
        title = "Github Users"
        view.addSubview(tableView)
        tableView.register(MainDataCell.self, forCellReuseIdentifier: MainDataCell.identifier)
        tableView.rowHeight = 80
//        tableView.register(TableHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        viewModel.setUpNetwork()
        setupListeners()
        
//        filterAlphabet()
//        viewModel.fetchAllCategories()
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height-100-scrollView.frame.size.height) {
            if counter < 3 {
                counter = counter + 1
              viewModel.setUpNetwork()
                  setupListeners()
            }
          
        }
    }
   
   
    
   
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sectionTitles[section]
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.usedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainDataCell.identifier, for: indexPath) as? MainDataCell else {
            return UITableViewCell()
        }
        let item = viewModel.usedData[indexPath.row]
        
//        cell.delegate = self
        
        cell.configure(with: item)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? TableHeader
//        header?.configure(text: "A")
//        return header
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! MainDataCell
        let obj = viewModel.usedData[indexPath.row]
        let viewController = DetailsViewController()
        viewController.avatarId = obj.avatarName  ?? ""
        viewController.name = cell.titleLabel.text ?? ""
//        viewController.usedId = (allCars?.result[indexPath.row].id)!
//        UserDefaults.standard.set(viewController.usedId, forKey: "Myid")
//        viewController.configure(with: (allCars?.result[indexPath.row].imageURL)!)
//        viewController.modalPresentationStyle = .fullScreen
//        present(viewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    fileprivate func setupListeners() {
        let loader = self.showLoader()
        viewModel.completion = {
            DispatchQueue.main.async {
                self.viewModel.fetchAllCategories()
                self.tableView.reloadData()
            }
        }
        
        self.hideLoader(loader: loader)
//        filterAlphabet()
//        viewModel.completions = {
//            DispatchQueue.main.async {
//                self.mainCollectionView.reloadData()
//            }
//        }
    }
    
    
}

extension HomeViewController {
    func addObserverOnCategories() {
        let results = realmDB.objects(DataRealmModel.self)
        dataToken = results.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                tableView.reloadData()
                //let count = self?.billsVM.billCategoryList.count
//                self?.collectionHeight.constant = ceil(CGFloat((count ?? 0)/2)) * 120.0
//                self?.collectionHeight.constant = 250.0
//                self?.setUpCategoriesListener()
            case .update(_, _, _, _):
                // Query results have changed, so apply them to the UITableView
//                self?.setUpCategoriesListener()
                tableView.reloadData()
                //let count = self?.billsVM.billCategoryList.count
//                self?.collectionHeight.constant = 250.0
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("NOTIFICATION ERROR -> \(error)")
            }
        }
    }
}

extension UIViewController {
    
    // MARK: Show loader on View controller.
    func showLoader() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Please wait..", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.style = .large
        alert.view.addSubview(indicator)
        self.parent?.present(alert, animated: true, completion: nil)
        return alert
    }
    
    // MARK: Show loader on View controller.
    func hideLoader(loader : UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: Set custom back button.
    func setBackButton(){
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(back(sender:)))
    }
    
    @objc func back(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated:true)
    }
}

// MARK: Capitalize first letter in sentance.
extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}

