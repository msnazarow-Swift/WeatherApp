//
//  DayCell.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import UIKit
class DayCell: WeatherCell {
    static let identifier = "DayCell"
    let dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 14 * fontTrans)
        return label
    }()

    let weatherImg: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    let maxTempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont(name: "Roboto-Medium", size: 14 * fontTrans)
        return label
    }()

    let minTempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont(name: "Roboto-Regular", size: 14 * fontTrans)
        return label
    }()

    lazy var vstack: UIStackView = {
        let img = UIView()
        img.addSubview(weatherImg)
        let stack = UIStackView(arrangedSubviews: [dayOfWeekLabel, img, maxTempLabel, minTempLabel])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.setCustomSpacing(-70, after: maxTempLabel)
        weatherImg.contentMode = .scaleAspectFit
        weatherImg.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(24 * fontTrans)
            make.width.equalTo(24 * fontTrans)
        }
        return stack
    }()

    override func updateViews() {
        guard let model = model as? DayCellModel else { return }
        dayOfWeekLabel.text = model.dayOfWeek
        // TODO: - Ячейка обращается напрямую к сервису
        weatherImg.image = StorageService.shared.getImageForKey(model.weatherImg)
        maxTempLabel.text = String(model.maxTemp)
        minTempLabel.text = String(model.minTemp)
        contentView.addSubview(vstack)
        vstack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 14))
    }
}
