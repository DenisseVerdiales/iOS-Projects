//
//  UIView.swift
//  Capture
//
//  Created by Consultant on 9/15/22.
//

import UIKit

extension UIView {
    
    func bindToSuperView(top: Int, left: Int, bottom: Int, right:Int) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: CGFloat(top), left: CGFloat(left), bottom: CGFloat(bottom), right: CGFloat(right))
        guard let superSafe = self.superview?.safeAreaLayoutGuide else {
            fatalError("Forgot to add the view to the view hierarchy. FIX IT!")
        }
        
        self.topAnchor.constraint(equalTo: superSafe.topAnchor, constant: insets.top).isActive = true
        self.leadingAnchor.constraint(equalTo: superSafe.leadingAnchor, constant: insets.left).isActive = true
        self.trailingAnchor.constraint(equalTo: superSafe.trailingAnchor, constant: -insets.right).isActive = true
        self.bottomAnchor.constraint(equalTo: superSafe.bottomAnchor, constant: -insets.bottom).isActive = true
    }
    
    static func createBufferView() -> UIView {
          let view = UIView(frame: .zero)
          view.translatesAutoresizingMaskIntoConstraints = false
          view.backgroundColor = .clear
          view.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
          view.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
          view.setContentCompressionResistancePriority(UILayoutPriority(1), for: .vertical)
          view.setContentCompressionResistancePriority(UILayoutPriority(1), for: .horizontal)

          return view
    }

}
