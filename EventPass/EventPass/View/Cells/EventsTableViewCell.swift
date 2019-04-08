//
//  EventsTableViewCell.swift
//  EventPass
//
//  Created by Carlos Marcelo Tonisso Junior on 4/1/19.
//  Copyright © 2019 Carlos Marcelo Tonisso Junior. All rights reserved.
//

import UIKit
import Cartography

class EventsTableViewCell: UITableViewCell {

    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let titleBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Teste"
        label.font = UIFont(name: "Avenir-Medium", size: 20)
        label.textColor = .white
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Teste"
        label.font = UIFont(name: "Avenir-Light", size: 12)
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInitialState()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupInitialState() {
        self.selectionStyle = .none
        addSubviews()
        setupBackgroundView()
        setupTitleBackgroundView()
        setupLabels()
    }
    
    func addSubviews() {
        self.contentView.addSubview(backgroundImageView)
        self.contentView.addSubview(titleBackgroundView)
        self.titleBackgroundView.addSubview(titleLabel)
        self.titleBackgroundView.addSubview(addressLabel)
    }
    
    func setupBackgroundView() {
        constrain(backgroundImageView) { view in
            guard let superview = view.superview else { return }
            view.width == superview.width
            view.height == 190
            view.top == superview.top
            view.centerX == superview.centerX
        }
    }
    
    func setupTitleBackgroundView() {
        constrain(titleBackgroundView) { view in
            guard let superview = view.superview else { return }
            view.width == superview.width
            view.height == 50
            view.bottom == superview.bottom
            view.centerX == superview.centerX
        }
    }
    
    func setupLabels() {
        constrain(titleLabel, addressLabel) { title, address in
            guard let superview = title.superview else { return }
            title.height == superview.height * 0.6
            title.width == superview.width
            title.centerX == superview.centerX
            title.top == superview.top
            address.height == superview.height * 0.4
            address.width == superview.width
            address.top == title.bottom
            address.bottom == superview.bottom
            address.centerX == superview.centerX
        }
    }

    func configureFor(_ event: Event) {
        
    }
}
