//
//  UIView+Ext.swift
//  Dating
//
//  Created by Agil Madinali on 10/25/20.
//

import UIKit

extension UIView {
    
    func adjustConstraints() {
        if let parentView = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            
            let heightConstant = parentView.bounds.height * 0.3 / 2
            let widthConstant = parentView.bounds.width * 0.2 / 2

            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: parentView.topAnchor, constant: heightConstant),
                self.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -heightConstant),
                self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: widthConstant),
                self.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -widthConstant)
            ])
        }
    }
    
    func addShadow(to view: UIView) -> UIView {
        
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        let shadowView = UIView(frame: frame)
        let shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 14.0)
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowRadius = 8.0
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: CGFloat(0.0), height: CGFloat(0.0))
        shadowView.layer.shadowOpacity = 0.15
        shadowView.layer.shadowPath = shadowPath.cgPath
        insertSubview(shadowView, at: 0)
        return shadowView
    }
}
