//
//  HeaderView.swift
//  test int
//
//  Created by Артём Скрипкин on 21.08.2022.
//

import UIKit

protocol HeaderViewDelegate: AnyObject {
    func didTapAvatar(frame: CGRect)
}

class HeaderView: UITableViewHeaderFooterView {
    @IBOutlet fileprivate var imageView: UIImageView!
    @IBOutlet fileprivate var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapAvatar))
        imageView.addGestureRecognizer(tap)
    }
    
    @objc func didTapAvatar() {
        delegate?.didTapAvatar(frame: convert(imageView.frame, to: nil))
    }
    
    weak var delegate: HeaderViewDelegate?
}

extension HeaderView {
    func configure(label: String, image: UIImage?) {
        nameLabel.text = label
        imageView.image = image
    }
}
