//
//  TruckListTableViewCell.swift
//  TruckAssignmentRemoteTech
//
//  Created by Yogesh on 16/10/21.
//

import UIKit

class TruckListTableViewCell: UITableViewCell {

  @IBOutlet var cellBackView: UIView!
  @IBOutlet var rectBackView: UIView!
  
  @IBOutlet var truckNumberLabel: UILabel!
  
  @IBOutlet var truckRunStateLabel: UILabel!
  @IBOutlet var stopRunStatusLabel: UILabel!
  @IBOutlet var daysAgoLabel: UILabel!
  @IBOutlet var speedLabel: UILabel!
  @IBOutlet var truckImg: UIImageView!
  @IBOutlet var kmhrLabel: UILabel!
  @IBOutlet var timeLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
