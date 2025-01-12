//
//  CoinRowTableViewCell.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 12/01/2025.
//

import Foundation
import SwiftUI

final class CoinRowTableViewCell: UITableViewCell {
    static let reuseIdentifier = "\(CoinRowTableViewCell.self)"
    private var hostingController: UIHostingController<CoinRowView>?

    func configure(with coin: Coin, forRowAt index: Int) {
        selectionStyle = .none
        
        let view = CoinRowView(position: index + 1, coin: coin)
        if let hostingController = hostingController {
            hostingController.view.removeFromSuperview()
        }

        let controller = UIHostingController(rootView: view)
        hostingController = controller
        contentView.addSubview(controller.view)

        controller.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            controller.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            controller.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            controller.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
