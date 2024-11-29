//
//  MainViewController.swift
//  DepositApp1
//
//  Created by Bolys Malik on 29.11.2024.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    let viewModel = MainViewModel()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "KZT", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "USD", at: 1, animated: true)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    private lazy var sumTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Сумма депозита"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(onChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private let sumTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor.systemTeal
        return label
    }()
    
    private let termLabel: UILabel = {
        let label = UILabel()
        label.text = "Срок хранение"
        label.textColor = UIColor.secondaryLabel
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    private let depositeResultLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы накопите"
        label.textColor = UIColor.secondaryLabel
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    private let resultSumLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private let depositeInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Расчет является предварительным"
        label.textColor = UIColor.secondaryLabel
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    private let view1: TextFieldView = {
        let view = TextFieldView()
        return view
    }()
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor=UIColor.secondaryLabel
        return view
    }()
    private let view2: TextFieldView = {
        let view = TextFieldView()
        return view
    }()
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Продолжить", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }

    private func setupView() {
        navigationItem.title = "Открытие депозита"
        view.backgroundColor = .systemBackground
        [segmentedControl, sumTextField, sumTitleLabel, termLabel, collectionView, depositeResultLabel, resultSumLabel, depositeInfoLabel,view1,view2,divider,button].forEach { item in
            view.addSubview(item)
        }
        viewModel.currentSelected = IndexPath(item: 0, section: 0)
        sumTitleLabel.text = "Минимальная сумма \(viewModel.currency.rawValue)"
        view1.configure(text1: "Ставка вознагрождения", text2: String(viewModel.getRateRew(currency: viewModel.currency)))
        view2.configure(text1: "Эффективная ставка(ГЭСВ)", text2: String(viewModel.getRateEff(currency: viewModel.currency)))
        resultSumLabel.text = "0.0"
    }
    
    private func setupConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        sumTextField.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        sumTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(sumTextField.snp.bottom).offset(6)
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        termLabel.snp.makeConstraints { make in
            make.top.equalTo(sumTitleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(termLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(80)
        }
        
        depositeResultLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        resultSumLabel.snp.makeConstraints { make in
            make.top.equalTo(depositeResultLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        depositeInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(resultSumLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        view1.snp.makeConstraints { make in
            make.top.equalTo(depositeInfoLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        divider.snp.makeConstraints { make in
            make.top.equalTo(view1.snp.bottom).offset(16)
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(16)

        }
        view2.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        button.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(48)
            make.leading.trailing.equalToSuperview().inset(16)
        }

    }
    
    @objc private func segmentAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            viewModel.currency = .kzt
        case 1:
            viewModel.currency = .usd
        default: break
        }
        sumTitleLabel.text = "Минимальная сумма \(viewModel.currency.rawValue)"
        view1.configure(text1: "Ставка вознагрождения", text2: String(viewModel.getRateRew(currency: viewModel.currency)))
        view2.configure(text1: "Эффективная ставка(ГЭСВ)", text2: String(viewModel.getRateEff(currency: viewModel.currency)))
        resultSumLabel.text = String(viewModel.calculateSum(rate: viewModel.getRateRew(currency: viewModel.currency), months: viewModel.months, principal: Double(sumTextField.text ?? "") ?? 0))
    }
    
    @objc private func onChanged(_ text: UITextField) {
        resultSumLabel.text = String(viewModel.calculateSum(rate: viewModel.getRateRew(currency: viewModel.currency), months: viewModel.months, principal: Double(text.text ?? "") ?? 0))
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MainCollectionViewCell
        let isSelected = viewModel.currentSelected == indexPath
        cell?.configure(title: viewModel.monthsTitle[indexPath.item], isSelected: isSelected)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.currentSelected = indexPath
        
        
        switch indexPath.item {
        case 0:
            viewModel.months = .three
        case 1:
            viewModel.months = .six
        case 2:
            viewModel.months = .twelve
        default: break
        }
        resultSumLabel.text = String(viewModel.calculateSum(rate: viewModel.getRateRew(currency: viewModel.currency), months: viewModel.months, principal: Double(sumTextField.text ?? "") ?? 0))
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
}
