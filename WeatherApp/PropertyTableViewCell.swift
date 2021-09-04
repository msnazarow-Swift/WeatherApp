//
//  PropertyTableViewCell.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import UIKit

class PropertyTableViewCell: UITableViewCell {
  static let identifier = "PropertyTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    detailTextLabel?.font = UIFont(name: "Roboto-Regular", size: 30 * fontTrans)
    textLabel?.font = UIFont(name: "Roboto-Regular", size: 11 * fontTrans)
    textLabel?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
