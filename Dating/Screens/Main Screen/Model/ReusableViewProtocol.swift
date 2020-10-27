//
//  ReusableViewProtocol.swift
//  Dating
//
//  Created by Agil Madinali on 10/25/20.
//

import UIKit

protocol ReusableViewProtocol: AnyObject {
    func handleView(with sender: UIPanGestureRecognizer)
}
