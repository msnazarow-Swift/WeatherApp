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
        label.font = .regular(14 * verticalTranslation)
        return label
    }()

    let weatherImg: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    let maxTempLabel: UILabel = {
        let label = UILabel()
        label.font = .medium(14 * verticalTranslation)
        return label
    }()

    let minTempLabel: UILabel = {
        let label = UILabel()
        label.font = .regular(14 * verticalTranslation)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        [dayOfWeekLabel, weatherImg, maxTempLabel, minTempLabel].forEach { addSubview($0) }

        minTempLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-14)
            make.left.greaterThanOrEqualTo(maxTempLabel.snp.right).offset(18)
        }

        maxTempLabel.snp.makeConstraints { make in
            make.right.lessThanOrEqualTo(-48 * horisontalTranslation)
            make.right.lessThanOrEqualTo(minTempLabel.snp.left).offset(-18 * horisontalTranslation)
            make.centerY.equalToSuperview()
        }

        weatherImg.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(10)
            make.right.lessThanOrEqualTo(-157 * horisontalTranslation)
            make.height.equalTo(weatherImg.snp.width)
            make.top.equalToSuperview().offset(18.5)
            make.bottom.equalToSuperview().inset(18.5)
            make.right.lessThanOrEqualTo(maxTempLabel.snp.left).offset(-93 * horisontalTranslation)
        }

        dayOfWeekLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
//        snp.makeConstraints { make in
//            make.height.equalTo(61)
//        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateViews() {
        guard let model = model as? DayCellModel else { return }
        dayOfWeekLabel.text = model.dayOfWeek
        // TODO: - Ячейка обращается напрямую к сервису
        weatherImg.image = StorageService.shared.getImageForKey(model.weatherImg)
        maxTempLabel.text = String(model.maxTemp)
        minTempLabel.text = String(model.minTemp)
    }
}
