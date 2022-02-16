//
//  UIView + Preview.swift
//  PentasReality
//
//  Created by Ikmal Azman on 03/02/2022.
//

import SwiftUI

extension UIView {
    private struct Preview : UIViewRepresentable {
        // This variable allow to inject current view
        let view : UIView
        
        func makeUIView(context: Context) -> some UIView {
            view.frame = .zero
            return view
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {
            
        }
    }
    /// Inject current view controller for preview
    func toPreview() -> some View {
        Preview(view : self)
    }
}
