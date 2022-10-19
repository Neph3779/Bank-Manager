//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    enum Section {
        case judging
        case working
        case waiting

        var name: String {
            switch self {
            case .judging:
                return "심사중"
            case .working:
                return "업무중"
            case .waiting:
                return "대기중"
            }
        }
    }
    private var diffableDatasource: UICollectionViewDiffableDataSource<Section, Customer>!
    private let topTimerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "업무시간"
        return label
    }()
    private let judgingLabel = ColorLabel(backgroundColor: .orange, text: Section.judging.name)
    private let workingOnLabel = ColorLabel(backgroundColor: .systemGreen, text: Section.working.name)
    private let waitngLabel = ColorLabel(backgroundColor: .systemBlue, text: Section.waiting.name)
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var bankerCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout())
        collectionView.register(BankerCollectionViewCell.self, forCellWithReuseIdentifier: BankerCollectionViewCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    private let addCustomerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("고객 10명 추가", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    private let resetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("초기화", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        return button
    }()
    private let bottomButtonsStackView = BankStackView(axis: .horizontal, distribution: .fillEqually)
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTopTimerLabel()
        setBottomButtonsStackView()
        setLabelStackView()
        setBankerCollectionView()
        applyDataSource()
        setAddCustomerButtonTarget()
        setResetButtonTarget()
    }

    private func compositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                  heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .absolute(self.bankerCollectionView.frame.height / 3))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = 20
            return section
        }
        return layout

        // NOTE: 아래의 코드로는 동작하지 않음 (이유 아직 모름)
        /*
         let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                               heightDimension: .fractionalHeight(1))
         let item = NSCollectionLayoutItem(layoutSize: itemSize)

         let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(self.bankerCollectionView.frame.height / 3))
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)

         let section = NSCollectionLayoutSection(group: group)
         section.orthogonalScrollingBehavior = .continuous
         section.interGroupSpacing = 20

         let compositionalLayout = UICollectionViewCompositionalLayout(section: section)

         return compositionalLayout
         */
    }
    
    private func setTopTimerLabel() {
        view.addSubview(topTimerLabel)
        NSLayoutConstraint.activate([
            topTimerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topTimerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }

    private func setBottomButtonsStackView() {
        view.addSubview(bottomButtonsStackView)
        NSLayoutConstraint.activate([
            bottomButtonsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomButtonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomButtonsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        bottomButtonsStackView.addArrangedSubview(addCustomerButton)
        bottomButtonsStackView.addArrangedSubview(resetButton)
    }

    private func setLabelStackView() {
        view.addSubview(labelStackView)
        NSLayoutConstraint.activate([
            labelStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            labelStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: bottomButtonsStackView.topAnchor),
            labelStackView.widthAnchor.constraint(equalToConstant: 100)
        ])

        [judgingLabel, workingOnLabel, waitngLabel].forEach { labelStackView.addArrangedSubview($0) }
    }

    private func setBankerCollectionView() {
        diffableDatasource = UICollectionViewDiffableDataSource<Section, Customer>(
            collectionView: bankerCollectionView) { collectionView, indexPath, customer in
                guard let cell = collectionView
                    .dequeueReusableCell(withReuseIdentifier: BankerCollectionViewCell.reuseIdentifier,
                                         for: indexPath) as? BankerCollectionViewCell else { return UICollectionViewCell() }
                cell.setContents(customer: customer)
                return cell
        }
            view.addSubview(bankerCollectionView)
            NSLayoutConstraint.activate([
            bankerCollectionView.leadingAnchor.constraint(equalTo: labelStackView.trailingAnchor),
            bankerCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bankerCollectionView.bottomAnchor.constraint(equalTo: bottomButtonsStackView.topAnchor),
            bankerCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    private func applyDataSource() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Customer>()
        snapShot.appendSections([.judging, .working, .waiting])
        snapShot.appendItems(viewModel.judging, toSection: .judging)
        snapShot.appendItems(viewModel.working, toSection: .working)
        snapShot.appendItems(viewModel.waiting, toSection: .waiting)
        diffableDatasource.apply(snapShot)
    }

    private func setAddCustomerButtonTarget() {
        addCustomerButton.addTarget(self, action: #selector(addCustomerButtonTouched(_:)), for: .touchUpInside)
    }

    @objc private func addCustomerButtonTouched(_ sender: UIButton) {
        let randomCustomers = viewModel.randomGenerator.generateRandomCustomer(count: 10)
        viewModel.waiting += randomCustomers
        var snapShot = diffableDatasource.snapshot()
        snapShot.appendItems(randomCustomers, toSection: .waiting)
        diffableDatasource.apply(snapShot)

        viewModel.waiting.forEach {
            let customerOperation = HandleCustomerOperation(customer: $0, delegate: self)
            viewModel.bankOperationQueue.addOperation(customerOperation)
        }
    }

    private func setResetButtonTarget() {
        resetButton.addTarget(self, action: #selector(resetButtonTouched(_:)), for: .touchUpInside)
    }

    @objc private func resetButtonTouched(_ sender: UIButton) {
        viewModel.waiting.removeAll()
        viewModel.working.removeAll()
        viewModel.judging.removeAll()
        applyDataSource()
    }
}

extension ViewController: ViewControllerDelegate {
    func depositStarted(customer: Customer) {
        DispatchQueue.main.async {
            if let index = self.viewModel.waiting.firstIndex(of: customer) {
                self.viewModel.waiting.remove(at: index)
                self.viewModel.working.append(customer)
                self.applyDataSource()
            }
        }
    }

    func depositEnded(customer: Customer) {
        DispatchQueue.main.async {
            if let index = self.viewModel.working.firstIndex(of: customer) {
                self.viewModel.working.remove(at: index)
                self.applyDataSource()
            }
        }
    }

    func loanStarted(customer: Customer) {
        DispatchQueue.main.async {
            if let index = self.viewModel.waiting.firstIndex(of: customer) {
                self.viewModel.waiting.remove(at: index)
                self.viewModel.working.append(customer)
                self.applyDataSource()
            }
        }
    }

    func loanEnded(customer: Customer) {
        DispatchQueue.main.async {
            if let index = self.viewModel.working.firstIndex(of: customer) {
                self.viewModel.working.remove(at: index)
                self.applyDataSource()
            }
        }
    }

    func loanJudgeStarted(customer: Customer) {
        var judgingCustomer = customer
        judgingCustomer.isJudging = true
        DispatchQueue.main.async {
            self.viewModel.judging.append(judgingCustomer)
            self.applyDataSource()
        }
    }

    func loanJudgeEnded(customer: Customer) {
        var judgeEndCustomer = customer
        judgeEndCustomer.isJudging = true
        DispatchQueue.main.async {
            if let index = self.viewModel.judging.firstIndex(of: judgeEndCustomer) {
                self.viewModel.judging.remove(at: index)
                self.applyDataSource()
            }
        }
    }
}
