//
//  UIView.swift
//  test int
//
//  Created by Артём Скрипкин on 21.08.2022.
//

import UIKit

extension UIView {
    class var identifier: String {
        String(describing: self)
    }
    
    func animate(duration: TimeInterval = 0.5, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: .curveEaseInOut,
            animations: animations,
            completion: completion
        )
    }
    
    static func fromNib<T: UIView>(_ view: T.Type) -> T {
        UINib(nibName: T.identifier, bundle: nil).instantiate(withOwner: nil)[0] as? T ?? T()
    }
}
