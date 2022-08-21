//
//  BlurView.swift
//  test int
//
//  Created by Артём Скрипкин on 21.08.2022.
//

import UIKit

class BlurView: UIView {
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var closeButton: UIButton!
    
    @IBAction private func closeButtonTapped(_ sender: Any) {
        closeQuickLook()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true
    }
    
    // MARK: - Facade
    
    func configure(image: UIImage) {
        imageView.image = image
        imageView.frame = .zero
    }
    
    func animateQuickLook(from frame: CGRect) {
        startFrame = frame
        constraintImageViewToFrame(frame)
        isHidden = false
        animateBackground(true) {
            self.animateAvatarToCenter {
                self.animateCloseButton(true)
            }
        }
    }
    
    // MARK: - Private
    
    private func closeQuickLook() {
        removeAllConstraintsForImageView()
        animateCloseButton(false) {
            self.animateAvatarToStart {
                self.animateBackground(false) {
                    self.isHidden = true
                    self.removeAllConstraintsForImageView()
                }
            }
        }
    }
    
    private func animateCloseButton(_ isOn: Bool, completion: @escaping () -> Void = {}) {
        animate(
            duration: 0.3,
            animations: { [unowned self] in
                closeButton.layer.opacity = isOn ? 1 : 0
            },
            completion: { _ in completion() }
        )
    }
    
    private func animateBackground(_ isOn: Bool, completion: @escaping () -> Void = {}) {
        animate(
            animations: { [unowned self] in
                backgroundColor = UIColor.systemGray3.withAlphaComponent(isOn ? 0.7 : 0)
            },
            completion: { _ in completion() }
        )
    }
    
    private func animateAvatarToCenter(_ completion: @escaping () -> Void) {
        removeAllConstraintsForImageView()
        animate(
            animations: { [unowned self] in
                constraintImageViewToCenter()
            },
            completion: { _ in completion() }
        )
    }
    
    private func animateAvatarToStart(_ completion: @escaping () -> Void) {
        animate(
            animations: { [unowned self] in
                guard let frame = startFrame else { return }
                constraintImageViewToFrame(frame)
                layoutSubviews()
            },
            completion: { _ in completion() }
        )
    }
    
    private func constraintImageViewToCenter() {
        guard let aspectRatio = calculateAspectRatio() else { return }
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: aspectRatio)
        ])
        layoutSubviews()
    }
    
    private func constraintImageViewToFrame(_ frame: CGRect) {
        NSLayoutConstraint.activate([
            self.imageView.widthAnchor.constraint(equalToConstant: frame.width),
            self.imageView.heightAnchor.constraint(equalToConstant: frame.height),
            self.imageView.topAnchor.constraint(equalTo: topAnchor, constant: frame.minY),
            self.imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: frame.minX)
        ])
        layoutSubviews()
    }
    
    private func removeAllConstraintsForImageView() {
        imageView.removeConstraints(imageView.constraints)
        constraints.forEach {
            guard let firstItem = $0.firstItem as? UIView,
                  let secondItem = $0.secondItem as? UIView else { return }
            if firstItem == imageView || secondItem == imageView {
                removeConstraint($0)
            }
        }
    }
    
    private func calculateAspectRatio() -> CGFloat? {
        guard let wPoints = imageView.image?.size.width,
              let hPoints = imageView.image?.size.height else { return nil }
        return hPoints / wPoints
    }
    
    private var startFrame: CGRect?
}
