//
//  MovieDetailCell.swift
//  MovieDB
//
//  Created by Thilak k on 27/04/22.
//

import UIKit

class MovieDetailCell: UITableViewCell {

    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgBanner: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView(movie:Event){
//        lblTitle.text = movie.title
//        lblDescription.text = movie.overview
//        lblReleaseDate.text = movie.releaseDate
//        let url = URL(string: Api.imageBaseUrl + movie.posterPath!)
//        imgBanner.af_setImage(withURL: (url )!)//?? URL(string: "")
    
    }

}
