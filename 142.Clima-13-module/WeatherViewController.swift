//
//  ViewController.swift
//  142.Clima-13-module
//
//  Created by Валентин Картошкин on 20.02.2025.
//

import UIKit
import SnapKit

class WeatherViewController: UIViewController {

    // MARK: - UI
    
    private lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: Constants.background)    //отсылка на файл Constants.swift, который есть у нас в проекте, там в этой переменной есть имя файла
        element.contentMode = .scaleAspectFill
        element.translatesAutoresizingMaskIntoConstraints = false   //необязательно при использовании SnapKit (но хуже не будет)
        return element
    }()
    
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 10
        element.alignment = .trailing   //выравнивание по правой стороне
        element.translatesAutoresizingMaskIntoConstraints = false   //необязательно при использовании SnapKit (но хуже не будет)
        return element
    }()
    
    private lazy var headerStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        //element.alignment = .fill   //выравнивание по заполнению - не помогло
        //element.distribution = .fill    //перевод - распределение
        element.translatesAutoresizingMaskIntoConstraints = false   //необязательно при использовании SnapKit (но хуже не будет)
        return element
    }()
    
    //кнопка определения геопозиции
    private lazy var geoButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(UIImage(systemName: Constants.geoSF), for: .normal)    //картинку для кнопки возьмем из SF (имя символа записано в Constants.geoSF)
        element.tintColor = .label  //.label - в соответствии с темой (Dark theme или Light theme)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    //окошко поиска
    private lazy var searchTextField: UITextField = {
        let element = UITextField()
        element.placeholder = Constants.search  //заполнитель (когда ничего не введено, будет написано Search)
        element.borderStyle = .roundedRect
        element.textAlignment = .right
        element.font = .systemFont(ofSize: 25)
        element.textColor = .label
        element.tintColor = .label
        element.backgroundColor = .systemFill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    //кнопка поиска
    private lazy var searchButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(UIImage(systemName: Constants.searchSF), for: .normal)    //картинку для кнопки возьмем из SF (имя символа записано в Constants.searchSF)
        element.tintColor = .label  //.label - в соответствии с темой (Dark theme или Light theme)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    //иконка погоды
    private lazy var condtitionalImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: Constants.conditionSF)
        element.tintColor = UIColor(named: Constants.weatherColor)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    //еще один стек
    private lazy var tempStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.tintColor = .label  //.label - в соответствии с темой (Dark theme или Light theme)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    //надпись с температурой
    private lazy var tempLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 80, weight: .black)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    //единица измерения температуры (Цельсия)
    private lazy var tempTypeLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 100, weight: .light)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    //надпись с названием города
    private lazy var cityLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 30)
        element.tintColor = .label  //.label - в соответствии с темой (Dark theme или Light theme)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let emptyView = UIView()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setupConstaints()
        
        view.backgroundColor = .green
    }
    
    // MARK: - setup Views
    
    private func setViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(headerStackView)
        
            headerStackView.addArrangedSubview(geoButton)
            headerStackView.addArrangedSubview(searchTextField)
            headerStackView.addArrangedSubview(searchButton)
        
        mainStackView.addArrangedSubview(condtitionalImageView)
        mainStackView.addArrangedSubview(tempStackView)
        
            tempStackView.addArrangedSubview(tempLabel)
            tempStackView.addArrangedSubview(tempTypeLabel)
        
        mainStackView.addArrangedSubview(cityLabel)
        mainStackView.addArrangedSubview(emptyView)
        
        tempLabel.text = "21"
        tempTypeLabel.text = Constants.celsius
        cityLabel.text = "London"
    }
 

}

// MARK: - Set Constraints

extension WeatherViewController {
    private func setupConstaints() {

        backgroundImageView.snp.makeConstraints { make in   //make - это то, что написано в начале строки (в данном случае это backgroundImageView
            make.top.leading.trailing.bottom.equalToSuperview()
//          make.edges.equalToSuperview()
        }

        mainStackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(24)    //offset - это отступ от equalToSuperview сверху вниз и слева направо, inset - это правильный и лучший способ сделать отступ от equalToSuperview - вроде spacing
        }
        
        headerStackView.snp.makeConstraints({make in make.width.equalToSuperview()})    //в нашем случае супервью для headerStackView будет не весь экран, а mainStackView. То есть тот вью, внутри которого он находится
        
        geoButton.snp.makeConstraints({make in
            make.width.equalTo(40)
        })
        
        condtitionalImageView.snp.makeConstraints({make in
            make.width.height.equalTo(120)
        })
        
        NSLayoutConstraint.activate([
//            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
//            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            
//            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
//            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
//            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
//            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
//            
//            headerStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
//            
//            geoButton.widthAnchor.constraint(equalToConstant: 40),
//            geoButton.heightAnchor.constraint(equalToConstant: 40),
//            
//            searchButton.widthAnchor.constraint(equalToConstant: 40),
//            searchButton.heightAnchor.constraint(equalToConstant: 40),
//
//            condtitionalImageView.widthAnchor.constraint(equalToConstant: 120),
//            condtitionalImageView.heightAnchor.constraint(equalToConstant: 120),

        ])
    }
}
