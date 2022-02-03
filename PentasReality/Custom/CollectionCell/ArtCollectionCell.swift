//
//  CustomCollectionViewCell.swift
//  PentasReality
//
//  Created by Ikmal Azman on 03/02/2022.
//

import UIKit

final class ArtCollectionCell: UICollectionViewCell {
    //MARK: - Outlets
    @IBOutlet weak var artImageView: UIImageView!
    //MARK: - Variables
    static let identifier = "cell"
      //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .purple
    }
    
    static func nib() -> UINib {
        UINib(nibName: "ArtCollectionCell", bundle: nil)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 15
    }
}

import SwiftUI

struct Preview : PreviewProvider {
    static var previews: some View {
        
        let view = UINib(nibName: "ArtCollectionCell", bundle: Bundle.main).instantiate(withOwner: nil, options: [:]).first as! ArtCollectionCell
        view.toPreview()
            .previewLayout(.sizeThatFits)
    }
}
