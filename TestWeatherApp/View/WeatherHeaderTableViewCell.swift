//
//  WeatherHeaderTableViewCell.swift
//  TestWeatherApp
//
//  Created by Javid Sheikh on 14/01/2018.
//  Copyright © 2018 Javid Sheikh. All rights reserved.
//

import UIKit

protocol WeatherHeaderDelegate {
    func getForecastForNew(location: String)
    func getForecastForCurrentLocation()
}

class WeatherHeaderTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    var delegate: WeatherHeaderDelegate?

    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var displayedWeatherLocationLabel: UILabel!
    @IBOutlet weak var newLocationTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        newLocationTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func getForecastForCurrentLocation(_ sender: Any) {
        delegate?.getForecastForCurrentLocation()
    }
    
    @IBAction func getForecast(_ sender: Any) {
        if let newLocation = newLocationTextField.text {
            delegate?.getForecastForNew(location: newLocation)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " {
            return true
        }
        let characterSet = CharacterSet.letters
        if string.rangeOfCharacter(from: characterSet.inverted) != nil {
            return false
        }
        return true
    }
}
