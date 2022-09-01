//
//  HeaderView.swift
//  OzeCodingChallenge
//
//  Created by Bakare Waris on 31/08/2022.
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
    
    func configure(text: String) {
        headerTitle.text = text
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
