//
//  ViewController.swift
//  142.Clima-13-module
//
//  Created by Валентин Картошкин on 20.02.2025.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: Constants.background)    //отсылка на файл Constants.swift, который есть у нас в проекте, там в этой переменной есть имя файла
        element.contentMode = .scaleAspectFill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setupConstaints()
        
        view.backgroundColor = .green
    }
    
    private func setViews() {
        view.addSubview(backgroundImageView)
    }
 

}

extension ViewController {
    private func setupConstaints() {

        backgroundImageView.snp.makeConstraints { make in   //make - это то, что написано в начале строки (в данном случае это backgroundImageView
            make.top.leading.trailing.bottom.equalToSuperview()
//          make.edges.equalToSuperview()
            
        }

        
        NSLayoutConstraint.activate([
//            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
//            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
}
