//
//  TaxiTableViewCell.swift
//  OlaApp
//
//  Created by Muneer KK on 22/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//

import UIKit
import SDWebImage

class TaxiTableViewCell: UITableViewCell {
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var colorLabel: CustomLabel!
    @IBOutlet weak var typeLabel: CustomLabel!
    @IBOutlet weak var fuelLabel: CustomLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK:- Set the currencyView componets using the currency object
    func configureCell(_ taxi:Taxi){
        numberLabel.text = taxi.vehicleNumber
        typeLabel.text   = taxi.group
        if let urlString = taxi.imgUrl, let url = URL(string: urlString){
            imageview.sd_setImage(with: url, placeholderImage: UIImage(named: OlaAppConstants.placeholderImage))
        }
        modelLabel.text  = (taxi.taxiDetails?.make ?? "") + "-" + (taxi.taxiDetails?.name ?? "")
        //colorLabel.text  = taxi.taxiDetails?.color
        if let type = taxi.taxiDetails?.fuelType, let typeValue  = FuelType.getFuelValue(type: type){
            fuelLabel.text   = typeValue.rawValue
        }
       

    }

}
