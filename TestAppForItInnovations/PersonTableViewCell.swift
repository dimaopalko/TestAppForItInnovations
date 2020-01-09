//
//  PersonTableViewCell.swift
//  TestAppForItInnovations
//
//  Created by Dima Opalko on 08.01.2020.
//  Copyright © 2020 Dima Opalko. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var favoriteButtonOutlet: UIButton!
    @IBOutlet weak var PDFButtonOutlet: UIButton!
    
    @IBOutlet weak var placeOfWorkLabel: UILabel!
    
    @IBOutlet weak var positionLabel: UILabel!
   
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        print("Favourite button tapped")
    }
    @IBAction func PDFButtonTapped(_ sender: Any) {
        print("pdf button tapped")
    }
    
}
