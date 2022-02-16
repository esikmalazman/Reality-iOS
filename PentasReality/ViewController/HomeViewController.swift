//
//  ArtCollectionViewController.swift
//  PentasReality
//
//  Created by Ikmal Azman on 28/01/2022.
//

import UIKit

final class HomeViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var collectionView : UICollectionView!
    
    //MARK: - Variables
    private var isViewflipped = false
    
    lazy var customNavBar : HeadNavigationBar = {
        let navView = HeadNavigationBar(nibName: XIBName.HeadNavigationBar.rawValue, bundle: Bundle.main)
        navView.view.translatesAutoresizingMaskIntoConstraints = false
        navView.view.dropShadow(opacity:0.1, radius: 0.7)
        return navView
    }()
    
    lazy var cardView : CardView = {
        let cardView = CardView(nibName: XIBName.CardView.rawValue, bundle: Bundle.main)
        cardView.view.translatesAutoresizingMaskIntoConstraints = false
        let shadowOffset = CGSize(width: 0, height: 0)
        cardView.view.dropShadow(offset: shadowOffset, radius: 10.0)
        return cardView
    }()
    
    lazy var sectionLabel : UILabel = {
        let label = UILabel()
        label.text = "Your collections"
        label.textColor = AppTheme.primaryColor
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var cardTabBar : CardTabBar = {
        let card = CardTabBar(nibName: XIBName.CardTabBar.rawValue, bundle: Bundle.main)
        card.view.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    lazy var cardDescription : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = label.font.withSize(18)
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupSectionLabel()
        setupCardView()
        setupCardDetails()
        setupCardDescription()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func animateFullScreenBlurView() {
        /// Remove all contraints in blurView
        for contraints in self.cardView.blurView.constraints {
            contraints.isActive = false
        }
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            
            if self.isViewflipped {
                self.cardTabBar.view.isHidden = self.isViewflipped
                NSLayoutConstraint.deactivate(self.cardView.blurView.constraints)
                self.cardView.layoutFlipCard()
                
            } else {
                self.cardDescription.isHidden = !self.isViewflipped
                self.cardTabBar.view.isHidden = self.isViewflipped
                NSLayoutConstraint.deactivate(self.cardView.flipBlurViewConstraints)
                self.cardView.layoutOriginalCardPosition()
            }
            self.view.layoutIfNeeded()
            
        } completion: { _ in
            if self.cardDescription.isHidden {
                self.cardDescription.isHidden = !self.isViewflipped
            }
        }
    }
    
    func hapticFeedback() {
        let feedbackGenerator = UISelectionFeedbackGenerator()
        feedbackGenerator.prepare()
        feedbackGenerator.selectionChanged()
    }
}

//MARK: - Private methods
extension HomeViewController {
    private func setupCardView() {
        add(cardView)
        cardView.delegate = self
        
        NSLayoutConstraint.activate([
            cardView.view.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.5),
            cardView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            cardView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            cardView.view.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 30)
            
        ])
    }
    
    private func setupCardDetails() {
        cardTabBar.delegate = self
        cardView.view.insertSubview(cardTabBar.view, aboveSubview: cardView.blurView)
        
        NSLayoutConstraint.activate([
            cardTabBar.view.topAnchor.constraint(equalTo: cardView.blurView.topAnchor),
            cardTabBar.view.leadingAnchor.constraint(equalTo: cardView.artImage.leadingAnchor,constant: 10),
            cardTabBar.view.trailingAnchor.constraint(equalTo: cardView.artImage.trailingAnchor, constant: -10),
            cardTabBar.view.bottomAnchor.constraint(equalTo: cardView.artImage.bottomAnchor)
        ])
    }
    private func setupNavbar() {
        add(customNavBar)
        
        NSLayoutConstraint.activate([
            customNavBar.view.heightAnchor.constraint(equalToConstant: 90),
            customNavBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavBar.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant : 0)
        ])
        customNavBar.navigationBarTitle.text = "Reality"
    }
    
    private func setupCardDescription() {
        cardView.view.insertSubview(cardDescription, aboveSubview: cardView.artImage)
        
        NSLayoutConstraint.activate([
            cardDescription.topAnchor.constraint(equalTo: cardView.artImage.topAnchor),
            cardDescription.bottomAnchor.constraint(equalTo: cardView.artImage.bottomAnchor),
            cardDescription.leadingAnchor.constraint(equalTo: cardView.artImage.leadingAnchor,constant:  20),
            cardDescription.trailingAnchor.constraint(equalTo: cardView.artImage.trailingAnchor, constant: -20),
        ])
        
        cardDescription.text = "This series consist of Octagonal-based Architectural Model as scale replicas of buildings in Malaysia."
    }
    
    private func setupSectionLabel() {
        view.addSubview(sectionLabel)
        
        NSLayoutConstraint.activate([
            sectionLabel.topAnchor.constraint(equalTo: customNavBar.view.bottomAnchor, constant: 10),
            sectionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
}

//MARK: - CardDetailsDelegate
extension HomeViewController : CardTabBarDelegate {
    
    func didTapViewInAR(_ view: CardTabBar, button: UIButton) {
        
        UIView.transition(with: self.view,
                          duration: 0.4,
                          options: .curveLinear,
                          animations: nil) { _ in
            
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "artViewVC") as! ArtViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        hapticFeedback()
    }
}

//MARK: - CardViewDelegate
extension HomeViewController : CardViewDelegate {
    
    func didTapLearnMore(_ view: CardView, button: UIButton) {
        
        isViewflipped = !isViewflipped
        
        UIView.transition(with: cardView.view,
                          duration: 0.5,
                          options: .transitionFlipFromRight,
                          animations: nil) { _ in
            self.animateFullScreenBlurView()
        }
        hapticFeedback()
    }
}

//import SwiftUI
//
//struct HomeViewControllerPreview : PreviewProvider {
//    static var previews: some View {
//        let view = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//        view.toPreview()
//    }
//}


