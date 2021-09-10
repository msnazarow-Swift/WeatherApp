//
//  DaySummaryStackView.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import UIKit

class DaySummaryStackView: UIStackView {
    let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "PLACEHOLDER"
        label.font = UIFont(name: "Roboto-Medium", size: 25 * fontTrans)
        return (label)
    }()

    let weatherLabel: UILabel = {
        let label = UILabel()
        label.text = "PLACEHOLDER"
        label.font = UIFont(name: "Roboto-Regular", size: 12 * fontTrans)
        return (label)
    }()

    let degreeLabel: UILabel = {
        let label = UILabel()
        label.text = "PLACEHOLDER"
        label.font = UIFont(name: "Roboto-Light", size: 60 * fontTrans)
        return (label)
    }()

    let minMaxLabel: UILabel = {
        let label = UILabel()
        label.text = "PLACEHOLDER"
        label.font = UIFont(name: "Roboto-Regular", size: 12 * fontTrans)
        return (label)
    }()
    let stroke: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1).cgColor
        return view
    }()
    let blank = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addArrangedSubview(cityLabel)
        addArrangedSubview(weatherLabel)
        addArrangedSubview(degreeLabel)
        addArrangedSubview(minMaxLabel)
        addArrangedSubview(stroke)
        addArrangedSubview(blank)
        stroke.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        axis = .vertical
        spacing = 5
        setCustomSpacing(17, after: minMaxLabel)
        setCustomSpacing(12, after: stroke)
        alignment = .center
    }

    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
