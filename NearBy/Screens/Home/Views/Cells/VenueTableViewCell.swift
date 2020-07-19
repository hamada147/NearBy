//
//  VenueTableViewCell.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/20/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import UIKit

class VenueTableViewCell: UITableViewCell {

    // MARK:- Outlets
    @IBOutlet weak var venueImage: UIImageView!
    @IBOutlet weak var venueTitle: UILabel!
    @IBOutlet weak var venueSummary: UILabel!
    
    var vm: VenueTableCellViewModel! {
        didSet {
            self.venueTitle.text = self.vm.title
            self.venueSummary.text = self.vm.summary
        }
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

class VenueTableCellViewModel {
    let title, summary: String
    
    init(title: String, summary: String) {
        self.title = title
        self.summary = summary
    }
}
