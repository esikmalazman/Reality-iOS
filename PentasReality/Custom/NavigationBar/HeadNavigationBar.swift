//
//  HeadNavigationBar.swift
//  PentasReality
//
//  Created by Ikmal Azman on 03/02/2022.
//

import UIKit

final class HeadNavigationBar: UIViewController {
    
    @IBOutlet weak var navigationBarTitle: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(ovalIn: profileImageView.bounds).cgPath
        profileImageView.layer.mask = maskLayer
    }
    
    
    
    
}
