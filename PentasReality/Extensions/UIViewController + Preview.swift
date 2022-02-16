//
//  UIViewController + Preview.swift
//  PentasReality
//
//  Created by Ikmal Azman on 03/02/2022.
//


import SwiftUI

extension UIViewController {
    private struct Preview : UIViewControllerRepresentable {
        // This variable allow to inject current view controller
        let viewController : UIViewController
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
    /// Inject current view controller for preview
    func toPreview() -> some View {
        Preview(viewController: self)
    }
}

extension UIViewController {
    /// Contraints using safe area guide of root view
    var guide : UILayoutGuide {
        return view.safeAreaLayoutGuide
    }
    /// Constraints using margin of the root view
    var margins : UILayoutGuide {
        return view.layoutMarginsGuide
    }
    /// Add Child view controller to Parent view controller
    func add(_ child : UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    /// Remove Child view controller to Parent view controller
    func remove(){
        // Make user the view controller is being added to parent
        guard parent != nil else {return}
        willMove(toParent: self)
        view.removeFromSuperview()
        removeFromParent()
    }
}



