//
//  HomeViewController.swift
//  LeagueMobileChallenge
//
//  Created by André Dias  on 13/08/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import UIKit
import Combine
import SwiftUI

class HomeViewController: UIViewController {
    
    var homeFeedItems: [HomeModel] = []
    private var subscriptions = Set<AnyCancellable>()
    
    private var errorView: UIView?
    
    private var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.style = .large
        view.color = .gray
        return view
    }()
    
    lazy var tableView: UITableView = {
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
        
        viewModel.outputs.isLoading.sink { isLoading in
            self.handleActivityIndicator(isLoading: isLoading)
        }.store(in: &subscriptions)
        
        viewModel.outputs.feed.sink { homeModel in
            self.errorView?.isHidden = true
            self.homeFeedItems = homeModel
            self.tableView.reloadData()
        }.store(in: &subscriptions)
        
        viewModel.outputs.error.sink { error in
            self.handleErrorView(error: error)
        }.store(in: &subscriptions)
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        self.view.addSubview(activityIndicator)
        self.navigationItem.title = Constants.homeTitle
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            
        self.activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.activityIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.activityIndicator.widthAnchor.constraint(equalToConstant: 50).isActive = true
     
    }
    
    private func handleActivityIndicator(isLoading: Bool) {
        DispatchQueue.main.async { [weak self] in
            if isLoading {
                self?.errorView?.isHidden = true
                self?.activityIndicator.isHidden = false
                self?.tableView.isHidden = true
                self?.activityIndicator.startAnimating()
            } else {
                self?.tableView.isHidden = false
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
                self?.view.layoutSubviews()
                self?.tableView.reloadData()
            }
        }
    }
    
    private func handleErrorView(error: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let errorViewSwiftUI = UIHostingController(rootView: ErrorViewSwiftUI(viewModel: self.viewModel, messageError: error))
            self.errorView = errorViewSwiftUI.view
            if let errorView = self.errorView {
                self.view.addSubview(errorView)
                errorView.isHidden = false
                self.tableView.isHidden = true
                
                self.errorView?.translatesAutoresizingMaskIntoConstraints = false
                self.errorView?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                self.errorView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
                self.errorView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
                self.errorView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                
                self.view.layoutSubviews()
            }
        }
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

