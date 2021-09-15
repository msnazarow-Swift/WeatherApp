//
//  DayCell.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import UIKit

final class DayCell: WeatherCell {
    static let identifier = "DayCell"

    let dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.font = .regular(14 * verticalTranslation)
        return label
    }()

    let weatherImg: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
            make.centerY.equalTo(safeAreaLayoutGuide)
            make.right.equalTo(safeAreaLayoutGuide).offset(-14)
            make.left.greaterThanOrEqualTo(maxTempLabel.snp.right).offset(18)
        }

        maxTempLabel.snp.makeConstraints { make in
            make.right.lessThanOrEqualTo(-48 * horisontalTranslation)
            make.right.lessThanOrEqualTo(minTempLabel.snp.left).offset(-18 * horisontalTranslation)
            make.centerY.equalTo(safeAreaLayoutGuide)
        }

        weatherImg.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide)
            make.centerX.equalTo(safeAreaLayoutGuide).offset(10)
            make.top.equalTo(safeAreaLayoutGuide).offset(18.5)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(18.5)
        }

        dayOfWeekLabel.snp.makeConstraints { make in
            make.left.equalTo(safeAreaLayoutGuide).offset(16)
            make.centerY.equalTo(safeAreaLayoutGuide)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateViews() {
        guard let model = model as? DayCellModel else { return }
        dayOfWeekLabel.text = model.dayOfWeek
        weatherImg.image = presenter?.getImage(for: model.weatherImg)
        maxTempLabel.text = String(model.maxTemp)
        minTempLabel.text = String(model.minTemp)
    }
}
