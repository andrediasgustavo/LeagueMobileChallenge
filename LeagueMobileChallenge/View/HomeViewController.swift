//
//  HomeViewController.swift
//  LeagueMobileChallenge
//
//  Created by André Dias  on 13/08/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import UIKit
import Combine

class HomeViewController: UIViewController, UITableViewDataSource {
    
    private var homeFeedItems: [HomeModel] = []
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.showsVerticalScrollIndicator = false
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.contentInset = .init(top: 0, left: 0, bottom: 20, right: 0)
        view.allowsSelection = false
        view.dataSource = self
        view.separatorStyle = .none
        view.backgroundColor = .white
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    
    private var viewModel: HomeViewModel
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: tableView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: tableView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: tableView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: tableView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        view.addConstraints([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])

        
        viewModel.outputs.feed.sink { homeModel in
            self.homeFeedItems = homeModel
            self.tableView.reloadData()
        }.store(in: &subscriptions)
    }
    
    
}

extension HomeViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.homeFeedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.homeFeedItems[indexPath.row].username
        return cell
    }
    
}

