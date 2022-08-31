//
//  ViewController.swift
//  OzeCodingChallenge
//
//  Created by Bakare Waris on 30/08/2022.
//

import UIKit


class TableHeader: UITableViewHeaderFooterView {
    
    static let identifer = "TableHeader"
    
    private let headerTitle: UILabel = {
        let title = UILabel()
        title.text = "Alphabets"
        title.font = .systemFont(ofSize: 22, weight: .semibold)
        title.textAlignment = .center
        return title
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(headerTitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        headerTitle.sizeToFit()
        headerTitle.frame = CGRect(x: 0,
                                   y: contentView.frame.size.height-10-headerTitle.frame.size.height,
                                   width: contentView.frame.size.width,
                                   height: headerTitle.frame.size.height)
    }
    
}

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()
    
    var sectionTitles = [String]()
    
    var viewModel =  GetDataViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(TableHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.setUpNetwork()
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "cell \(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        return header
    }

}

