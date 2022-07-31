//
//  TableViewController.swift
//  StarRatingControl_Example
//
//  Created by Rafael Moura on 31/07/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import StarRatingControl

private final class StarRatingCell: UITableViewCell {
    
    private lazy var ratingControl: SRRater = {
        
        let control = SRRater().usingAutoLayout()
        control.maximumValue = 5
        
        return control
    }()
    
    class var reuseIdentifier: String { String(describing: Self.self) }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        
        contentView.addSubview(ratingControl)
        contentView.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            ratingControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            ratingControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(value: Int) {
        
        ratingControl.value = value
    }
}

final class TableViewController: UITableViewController {
    
    private var ratings: [Int] = [0, 1, 2, 3, 4, 5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(StarRatingCell.self,
                           forCellReuseIdentifier: String(describing: StarRatingCell.reuseIdentifier))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return ratings.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: StarRatingCell.reuseIdentifier,
                                                 for: indexPath)
        
        guard let starRatingCell = cell as? StarRatingCell else { return cell }
        
        starRatingCell.configure(value: ratings[indexPath.row])
        
        return starRatingCell
    }
}
