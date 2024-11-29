//
//  TextFieldView.swift
//  DepositApp1
//
//  Created by Bolys Malik on 29.11.2024.
//

import UIKit

class TextFieldView: UIView {

    private let percentInfo: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.secondaryLabel
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    private let percentNum: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor.black
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(percentInfo)
        addSubview(percentNum)
        
        percentInfo.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
        }
        percentNum.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(text1:String,text2:String){
        percentInfo.text=text1
        percentNum.text="\(text2)%"
    }
}
