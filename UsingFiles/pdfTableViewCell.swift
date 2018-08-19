//
//  pdfTableViewCell.swift
//  UsingFiles
//
//  Created by Sukumar Anup Sukumaran on 19/08/18.
//  Copyright © 2018 TechTonic. All rights reserved.
//

import UIKit

class pdfTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var pdfLabel: UILabel!
    
    
    func config(pdfName: String) {
        
        self.pdfLabel.text = pdfName
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
