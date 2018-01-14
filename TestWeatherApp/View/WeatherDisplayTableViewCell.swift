//
//  WeatherDisplayTableViewCell.swift
//  TestWeatherApp
//
//  Created by Javid Sheikh on 13/01/2018.
//  Copyright © 2018 Javid Sheikh. All rights reserved.
//

import UIKit

class WeatherDisplayTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
