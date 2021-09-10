//
//  ViewController.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 10.09.2021.
//

import UIKit

class ViewController: UIViewController {
	let subview = DaySummaryStackView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(subview)
        view.backgroundColor = .white
        subview.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        subview.stroke.snp.makeConstraints { make in
            make.width.equalTo(view)
        }
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
