//
//  UIView+SuugarLayout.swift
//  Suugar
//
//  Created by thedoritos on 2019/03/24.
//

public extension UIView {
    func size(width: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    func size(height: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    func size(width: CGFloat, height: CGFloat) {
        size(width: width)
        size(height: height)
    }

    func matchParentWidth(margins: CGFloat = 0) {
        guard let parent = superview else { return }
        leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: margins).isActive = true
        parent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: margins).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    func matchParentHeight(margins: CGFloat = 0) {
        guard let parent = superview else { return }
        topAnchor.constraint(equalTo: parent.topAnchor, constant: margins).isActive = true
        parent.bottomAnchor.constraint(equalTo: bottomAnchor, constant: margins).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    func matchParent(margins: CGFloat = 0) {
        matchParentWidth(margins: margins)
        matchParentHeight(margins: margins)
    }
}
