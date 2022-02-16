//
//  CardView.swift
//  PentasReality
//
//  Created by Ikmal Azman on 09/02/2022.
//

import UIKit

protocol CardViewDelegate : AnyObject {
    func didTapLearnMore(_ view : CardView, button : UIButton)
}

final class CardView: UIViewController {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var artImage: UIImageView!
    @IBOutlet weak var infoBtn: UIButton!
    
    var blurView : UIVisualEffectView!
    var originalBlurViewConstraints : [NSLayoutConstraint]!
    var flipBlurViewConstraints : [NSLayoutConstraint]!
    
    private var vibranceView : UIVisualEffectView!
    weak var delegate : CardViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBlurView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.layer.cornerRadius = 15
        infoBtn.layer.cornerRadius = 15
        cardView.layer.cornerRadius = 15
        artImage.backgroundColor = .clear
        artImage.layer.cornerRadius = 15
        artImage.layer.borderWidth = 12
        artImage.layer.borderColor =  UIColor.white.cgColor
    }
    
    func layoutOriginalCardPosition() {
        
        originalBlurViewConstraints = [
            blurView.heightAnchor.constraint(equalToConstant: 100),
            blurView.widthAnchor.constraint(equalTo: artImage.widthAnchor),
            blurView.bottomAnchor.constraint(equalTo: artImage.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: artImage.leadingAnchor)
        ]
        
        originalBlurViewConstraints.forEach { item in
            item.isActive = true
        }
    }
    
    func layoutFlipCard() {
        
        flipBlurViewConstraints = [
            blurView.heightAnchor.constraint(equalTo: artImage.heightAnchor),
            blurView.topAnchor.constraint(equalTo: artImage.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: artImage.leadingAnchor),
            blurView.bottomAnchor.constraint(equalTo: artImage.bottomAnchor)
        ]
        
        flipBlurViewConstraints.forEach { item in
            item.isActive = true
        }
    }
}

//MARK: - Actions
extension CardView {
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        delegate?.didTapLearnMore(self, button: sender)
    }
}

//MARK: - Private methods
extension CardView {
    
    private func setupVibraceView(blurEffect : UIBlurEffect) {
        let vibranceEffect = UIVibrancyEffect(blurEffect: blurEffect)
        vibranceView = UIVisualEffectView(effect: vibranceEffect)
        vibranceView.translatesAutoresizingMaskIntoConstraints = false
        
        blurView.contentView.addSubview(vibranceView)
        
        NSLayoutConstraint.activate([
            vibranceView.heightAnchor.constraint(equalTo: blurView.contentView.heightAnchor),
            vibranceView.widthAnchor.constraint(equalTo: blurView.contentView.widthAnchor),
            vibranceView.centerXAnchor.constraint(equalTo: blurView.contentView.centerXAnchor),
            vibranceView.centerYAnchor.constraint(equalTo: blurView.contentView.centerYAnchor)
        ])
    }
    
    private func setupBlurView() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        artImage.insertSubview(blurView, aboveSubview: artImage)
        
        layoutOriginalCardPosition()
        setupVibraceView(blurEffect: blurEffect)
    }
}
