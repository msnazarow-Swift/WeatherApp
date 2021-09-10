//
//  SearchScreenHeaderStackView.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 10.09.2021.
//

import UIKit

class SearchScreenHeaderStackView: UIStackView {
	private
    let image: UIImage =   {
		let image = UIImage(systemName: "xmark")!
        return image.withTintColor(.black)
    }()
    lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(image, for: .normal)
        return button
    }()
//    lazy var closeButton =
    lazy var closeButton = UIBarButtonItem(customView: button)

    private
    lazy var toolbar: UIToolbar = {
        // TODO: - Без указания CGRect ломаются констрейнты
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 223, height: 24))
        let title: UILabel = {
            let label = UILabel()
            label.text = "Поиск Города"
            label.textAlignment = .center
            label.font = UIFont(name: "Roboto-Medium", size: 16)
            return label
        }()
        toolbar.isTranslucent = false
        toolbar.barTintColor = .white
        toolbar.setItems([closeButton,
                          UIBarButtonItem(systemItem: .flexibleSpace),
                          UIBarButtonItem(customView: title),
                          UIBarButtonItem(systemItem: .flexibleSpace)], animated: false)
        return toolbar
    }()
    let searchTextField = SearchTextField()
    let stroke: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1).cgColor
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addArrangedSubview(toolbar)
        addArrangedSubview(searchTextField)
        addArrangedSubview(stroke)
        axis = .vertical
        alignment = .fill
        distribution = .equalSpacing
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
