//
//  CardDetails.swift
//  PentasReality
//
//  Created by Ikmal Azman on 14/02/2022.
//

import UIKit

protocol CardTabBarDelegate : AnyObject{
    func didTapViewInAR(_ view : CardTabBar, button : UIButton)
}

final class CardTabBar: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var learnMoreBtn : UIButton!
    
    //MARK: - Variables
    weak var delegate : CardTabBarDelegate?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        learnMoreBtn.layer.cornerRadius = 15
    }
    
    //MARK: - Actions
    @IBAction func learnMoreButtonPressed(_ sender: UIButton) {
        delegate?.didTapViewInAR(self, button: sender)
    }
}
