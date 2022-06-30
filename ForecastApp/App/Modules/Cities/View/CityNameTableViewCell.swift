//
//  CityNameTableViewCell.swift
//  ForecastApp
//
//  Created by Cristian Sancricca on 29/06/2022.
//

import UIKit

class CityNameTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let identifier = "CityNameTableViewCell"
    
    let cityName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .left
        return label
     }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(cityName)
        cityName.centerY(inView: contentView,paddingLeft: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
