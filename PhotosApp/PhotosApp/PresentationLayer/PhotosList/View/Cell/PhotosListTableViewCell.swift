//
//  PhotosListTableViewCell.swift
//  PhotosApp
//
//  Created by Omayma Marouf on 22/08/2024.
//

import UIKit

class PhotosListTableViewCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var photoNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with photoData: PhotoDomainModel) {
        photoNameLbl.text = photoData.title
        photo.loadRemoteImageFrom(urlString: photoData.thumbnailURL!)
        
    }
}
