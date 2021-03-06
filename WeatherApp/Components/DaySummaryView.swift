//
//  DaySummaryStackView.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import UIKit

final class DaySummaryStackView: UIView {
    let cityLabel: UILabel = {
        let label = UILabel()
        label.font = .medium(25 * verticalTranslation)
        return (label)
    }()

    let weatherLabel: UILabel = {
        let label = UILabel()
        label.font = .regular(12 * verticalTranslation)
        return (label)
    }()

    let degreeLabel: UILabel = {
        let label = UILabel()
        label.font = .light(60 * verticalTranslation)
        return (label)
    }()

    let minMaxLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .regular(12 * verticalTranslation)
        return (label)
    }()

    let stroke: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.grey07.cgColor
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        [cityLabel, weatherLabel, degreeLabel, minMaxLabel, stroke].forEach { addSubview($0) }

        cityLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
        }

        weatherLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.greaterThanOrEqualTo(cityLabel.snp.bottom).offset(3)
        }

        degreeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.greaterThanOrEqualTo(weatherLabel.snp.bottom).offset(6)
        }

        minMaxLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.greaterThanOrEqualTo(degreeLabel.snp.bottom).offset(6)
        }

        stroke.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.centerX.width.equalToSuperview()
            make.top.equalTo(minMaxLabel.snp.bottom).offset(17)
            make.bottom.equalToSuperview()
        }
        snp.makeConstraints { make in
            make.height.equalTo(174 * verticalTranslation)
        }
    }

    override func didMoveToSuperview() {
        guard superview != nil else { return }
        snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }

    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
