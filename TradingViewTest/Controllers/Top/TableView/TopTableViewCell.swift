//
//  TopTableCell.swift
//  TradingViewTest
//
//  Created by Dmitrii Tikhomirov on 5/18/23.
//
import UIKit

final class TopTableViewCell: UITableViewCell {
  private let numberLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.font = .inter_14
    label.textColor = .text_light_steel_blue_2
    return label
  }()

  private let country: UIImageView = {
    var image = UIImageView()
    image.image = UIImage._108_armenia_o
    image.contentMode = .scaleAspectFit
    image.contentMode = .left
    image.clipsToBounds = true
    return image
  }()

  private let nameLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.font = .inter_14
    label.textColor = .textWhite
    return label
  }()

  private let depositLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .right
    label.font = .inter_14
    label.textColor = .textWhite
    return label
  }()

  private let profitLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .right
    label.font = .inter_14
    label.textColor = .text_medium_sea_green
    return label
  }()

  var names: [String]?
  var flags: [UIImage]?

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    setupLabels()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupLabels() {

    // Configure label properties and add them as subviews to the cell's content view
    numberLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(numberLabel)

    country.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(country)

    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(nameLabel)

    depositLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(depositLabel)

    profitLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(profitLabel)

    // Set constraints for the labels
    NSLayoutConstraint.activate([
      numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      numberLabel.widthAnchor.constraint(equalToConstant: 30),
      numberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

      country.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor),
      country.widthAnchor.constraint(equalToConstant: 60),
      country.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

      nameLabel.leadingAnchor.constraint(equalTo: country.trailingAnchor),
      nameLabel.widthAnchor.constraint(equalToConstant: 80),
      nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

      depositLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
      depositLabel.widthAnchor.constraint(equalToConstant: 80),
      depositLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

//      profitLabel.leadingAnchor.constraint(equalTo: depositLabel.trailingAnchor),
      profitLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      profitLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
  }



  func configureCell(row: Int) {
    // Configure the labels with data for the corresponding row
    numberLabel.text = "\(row + 1)"
    nameLabel.text = Resources.Names[row]
    country.image = Resources.countryFlags[row]
    depositLabel.text = "$" + Resources.deposit[row]
    profitLabel.text = "$" + Resources.profit[row]
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    // Reset the cell's properties as needed
    numberLabel.text = nil
    nameLabel.text = nil
    country.image = nil
    depositLabel.text = nil
    profitLabel.text = nil
  }
}
