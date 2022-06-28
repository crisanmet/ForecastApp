//
//  HourlyWeatherCollectionViewCell.swift
//  ForecastApp
//
//  Created by Cristian Sancricca on 28/06/2022.
//

import UIKit

class HourlyWeatherCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HourlyWeatherCollectionViewCell"
    
    private var weatherIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "sun.max")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return image
    }()
    
    private var hourLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.text = "12:00"
        return label
    }()
    
    private var weatherConditionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.text = "Nublado"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        contentView.backgroundColor = .white
            
            
        let stack = UIStackView(arrangedSubviews: [weatherIcon, hourLabel, weatherConditionLabel])
        stack.axis = .vertical
        stack.spacing = 2
        stack.alignment = .center
        addSubview(stack)
            
        stack.anchor(top: contentView.topAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(with model: ForecastModel){
        DispatchQueue.main.async { [weak self] in
            self?.weatherIcon.image = UIImage(systemName: model.conditionName)
            self?.weatherConditionLabel.text = model.text
        }
    }
}
