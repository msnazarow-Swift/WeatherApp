//
//  SettingsScreenViewController.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 12.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit

class SettingsScreenViewController: UIViewController, SettingsScreenViewProtocol {
	var presenter: SettingsScreenPresenterProtocol?

    let switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = .clear
        switcher.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        switcher.addTarget(self, action: #selector(switcherValueChanged), for: .valueChanged)
        return switcher
    }()

    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Неделя"
        return label
    }()

    let footerLabel: UILabel = {
        let label = UILabel()
        label.text = "Прогноз"
        return label
    }()

    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()

    var viewController: UIViewController { return self }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        [headerLabel, closeButton, switcher, footerLabel].forEach { view.addSubview($0) }

        switcher.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(switcher.snp.top).offset(-10)
        }
        footerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(switcher.snp.bottom).offset(10)
        }
        closeButton.snp.makeConstraints { make in
            make.top.left.equalTo(26)
        }
        presenter?.viewDidLoad()
    }

    @objc func switcherValueChanged(mySwitcher: UISwitch) {
        presenter?.switcherValueChanged(mySwitcher.isOn)
    }

    @objc func closeButtonTapped() {
        presenter?.closeView()
    }
    func setWeekMode(_ isWeekMode: Bool) {
        switcher.isOn = isWeekMode
    }
}
