//
//  MovileListCell.swift
//  MovieDB
//
//  Created by Thilak k on 27/04/22.
//

import UIKit
import AlamofireImage
class MovileListCell: UITableViewCell {

    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var movieOverlay: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupView(){
        movieOverlay.dropShadow()
        imgBanner.dropRadious()
        
    }
    func config(event:Event){
        lblTitle.text = event.venue.name
        lblSubtitle.text = event.venue.address
        let url = URL(string: event.performers[0].image)
        imgBanner.af_setImage(withURL: (url )!)
        lblDateTime.text = event.datetimeUTC.formatDate()
       
    }

}
