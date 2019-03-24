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

    func matchParent(axis: NSLayoutConstraint.Axis, margins: CGFloat = 0) {
        guard let parent = superview else { return }
        switch axis {
        case .horizontal:
            leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: margins).isActive = true
            parent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: margins).isActive = true
        case .vertical:
            topAnchor.constraint(equalTo: parent.topAnchor, constant: margins).isActive = true
            parent.bottomAnchor.constraint(equalTo: bottomAnchor, constant: margins).isActive = true
        }
        translatesAutoresizingMaskIntoConstraints = false
    }

    func matchParentWidth(margins: CGFloat = 0) {
        matchParent(axis: .horizontal, margins: margins)
    }

    func matchParentHeight(margins: CGFloat = 0) {
        matchParent(axis: .vertical, margins: margins)
    }

    func matchParent(margins: CGFloat = 0) {
        matchParent(axis: .horizontal, margins: margins)
        matchParent(axis: .vertical, margins: margins)
    }

    func center(axis: NSLayoutConstraint.Axis) {
        guard let parent = superview else { return }
        switch axis {
        case .horizontal:
            self.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        case .vertical:
            self.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
        }
    }

    func center() {
        center(axis: .horizontal)
        center(axis: .vertical)
    }
}
