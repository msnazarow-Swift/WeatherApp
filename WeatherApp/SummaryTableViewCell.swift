//
//  SummaryTableViewCell.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
  static let identifier = "Summary"
  let cityLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Roboto-Medium", size: 25)
    return (label)
  }()

  let weatherLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Roboto-Regular", size: 12)
    return (label)
  }()

  let degreeLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Roboto-Light", size: 60)
    return (label)
  }()

  let minMaxLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Roboto-Regular", size: 12)
    return (label)
  }()

  lazy var vStack: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [cityLabel, weatherLabel, degreeLabel, minMaxLabel])
    stack.axis = .vertical
    stack.spacing = 5
    stack.alignment = .center
    return (stack)
  }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  override func layoutSubviews() {
    super.layoutSubviews()
    cityLabel.text = "Moscow"
    degreeLabel.text = "21"
    minMaxLabel.text = "17 - 19"
    weatherLabel.text = "Sunny"
//    vStack.snp.makeConstraints { make in
//      make.center.equalToSuperview()
//    }
    sizeToFit()
  }
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

    contentView.addSubview(vStack)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
