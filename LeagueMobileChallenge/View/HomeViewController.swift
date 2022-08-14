//
//  HomeViewController.swift
//  LeagueMobileChallenge
//
//  Created by André Dias  on 13/08/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    private var homeFeedItems: [HomeModel] = []
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.showsVerticalScrollIndicator = false
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        view.allowsSelection = false
        view.dataSource = self
        view.separatorStyle = .singleLine
        view.backgroundColor = .white
        view.register(CustomViewCell.self, forCellReuseIdentifier: "CustomViewCell")
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
        
        self.setupView()
        viewModel.outputs.feed.sink { homeModel in
            self.homeFeedItems = homeModel
            self.tableView.reloadData()
        }.store(in: &subscriptions)
    }
    
    private func setupView() {
        self.view.addSubview(tableView)
        self.navigationItem.title = Constants.homeTitle
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.homeFeedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomViewCell(homeModel: self.homeFeedItems[indexPath.row])
        return cell
    }
    
}

