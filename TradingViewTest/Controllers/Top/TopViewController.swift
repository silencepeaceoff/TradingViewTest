//
//  TopViewController.swift
//  TradingViewTest
//
//  Created by Dmitrii Tikhomirov on 5/17/23.
//

import UIKit

final class TopViewController: UIViewController {

  private let topViewTitle: UILabel = {
    let titleView = UILabel()
    titleView.text = "TOP 10 Traders"
    titleView.font = .interBold22
    titleView.textColor = .textWhite
    titleView.textAlignment = .center
    return titleView
  }()

  private let background: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.backgroundTopView
    return view
  }()

  private let tableView = UITableView()

  private var timer: Timer?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupView()
    setupTableView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    // Start the timer to update values every 10 seconds
    timer = Timer.scheduledTimer(
      timeInterval: 10.0, target: self,
      selector: #selector(updateValues),
      userInfo: nil, repeats: true
    )
    timer?.tolerance = 0.1
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    // Create and set the table header view
    let headerView = createHeaderView()
    tableView.tableHeaderView = headerView
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    // Stop the timer
    timer?.invalidate()
    timer = nil
  }
}

extension TopViewController {

  func setupView() {
    view.addSubview(background)
    navigationItem.titleView = topViewTitle
    navigationController?.tabBarItem.title = "Top"

    background.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      background.topAnchor.constraint(equalTo: view.topAnchor),
      background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      background.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }

  private func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(TopTableViewCell.self, forCellReuseIdentifier: "TopCell")

    tableView.backgroundColor = .backgroundTopView
    tableView.rowHeight = 50
    tableView.separatorStyle = .none

    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false

    // Set constraints for the table view to fill the view's bounds
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
      tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
      tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 12)
    ])
  }

  private func createHeaderView() -> UIView {
    let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
    headerView.clipsToBounds = true
    headerView.layer.cornerRadius = 10

    // Top right corner, Top left corner
    headerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    headerView.backgroundColor = UIColor.background_dark_slate_gray_2

    let numberLabel = createHeaderLabel(withText: "№", alignment: .left, width: 30)
    let countryLabel = createHeaderLabel(withText: "Country", alignment: .left, width: 60)
    let nameLabel = createHeaderLabel(withText: "Name", alignment: .left, width: 80)
    let depositLabel = createHeaderLabel(withText: "Deposit", alignment: .right, width: 80)
    let profitLabel = createHeaderLabel(withText: "Profit", alignment: .right, width: 80)

    headerView.addSubview(numberLabel)
    headerView.addSubview(countryLabel)
    headerView.addSubview(nameLabel)
    headerView.addSubview(depositLabel)
    headerView.addSubview(profitLabel)

    NSLayoutConstraint.activate([
      numberLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
      numberLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),

      countryLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor),
      countryLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),

      nameLabel.leadingAnchor.constraint(equalTo: countryLabel.trailingAnchor),
      nameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),

      depositLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
      depositLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),

      profitLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
      profitLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
    ])

    return headerView
  }

  @objc func updateValues() {
    // Generate new random values for the cells
    let row = Int.random(in: 0..<10)
    let newDeposit = "\((Int(Resources.deposit[row]) ?? 0) + Int.random(in: 50...150))"
    let newProfit = "\((Int(Resources.profit[row]) ?? 0) + Int.random(in: 50...150))"
    Resources.deposit[row] = newDeposit
    Resources.profit[row] = newProfit
    print(newProfit, newDeposit)
    tableView.reloadData()
  }


  private func createHeaderLabel(withText text: String, alignment: NSTextAlignment, width: CGFloat) -> UILabel {
    let label = UILabel()
    label.font = .interMedium12
    label.textColor = .text_light_steel_blue_2
    label.text = text
    label.textAlignment = alignment
    label.translatesAutoresizingMaskIntoConstraints = false
    label.widthAnchor.constraint(equalToConstant: width).isActive = true
    return label
  }
}

extension TopViewController: UITableViewDelegate, UITableViewDataSource {

  // MARK: - UITableViewDataSource
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Return the number of rows in your data source
    return 10
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TopCell", for: indexPath) as! TopTableViewCell

    // Configure the cell with data for the corresponding row
    cell.configureCell(row: indexPath.row)

    return cell
  }

  // MARK: - UITableViewDelegate
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    // Apply different background colors for even number cells
    cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.backgroundTopView : UIColor.background_dark_slate_gray_2

    // Apply rounded corners to the bottom cell
    if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
      cell.clipsToBounds = true
      cell.layer.cornerRadius = 10
      cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
  }
}
