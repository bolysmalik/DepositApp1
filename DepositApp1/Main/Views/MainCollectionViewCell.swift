//
//  MainCollectionViewCell.swift
//  DepositApp1
//
//  Created by Bolys Malik on 29.11.2024.
//

import UIKit
import SnapKit

class MainCollectionViewCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.layer.borderWidth = 2
        contentView.layer.cornerRadius = 12
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(title: String, isSelected: Bool) {
        titleLabel.text = title
        if isSelected {
            titleLabel.textColor = UIColor.systemTeal
            contentView.layer.borderColor = UIColor.systemTeal.cgColor
        } else {
            titleLabel.textColor = UIColor.secondaryLabel
            contentView.layer.borderColor = UIColor.systemGray6.cgColor
        }
    }
}
