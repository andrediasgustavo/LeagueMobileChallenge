//
//  CustomViewCell.swift
//  LeagueMobileChallenge
//
//  Created by André Dias  on 14/08/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import SwiftUI
import UIKit

class CustomViewCell: UITableViewCell {
    
    init(homeModel: HomeModel) {
        super.init(style: .default, reuseIdentifier: "CustomViewCell")
        let cellSwiftUI = UIHostingController(rootView: ContentCellSwiftUI(homeModel: homeModel))
        contentView.addSubview(cellSwiftUI.view)
        cellSwiftUI.view.translatesAutoresizingMaskIntoConstraints = false
        
        cellSwiftUI.view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cellSwiftUI.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cellSwiftUI.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        cellSwiftUI.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
