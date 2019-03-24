//
//  UIView+SuugarLayout.swift
//  Suugar
//
//  Created by thedoritos on 2019/03/24.
//

public enum SuugarSize {
    case absolute(size: CGFloat)
    case matchParent(margins: CGFloat)
}

public extension UIView {
    func width(_ size: SuugarSize) {
        switch size {
        case .absolute(let size):
            self.widthAnchor.constraint(equalToConstant: size).isActive = true
        case .matchParent(let margins):
            guard let parent = superview else { return }
            leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: margins).isActive = true
            parent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: margins).isActive = true
        }
        translatesAutoresizingMaskIntoConstraints = false
    }

    func height(_ size: SuugarSize) {
        switch size {
        case .absolute(let size):
            self.heightAnchor.constraint(equalToConstant: size).isActive = true
        case .matchParent(let margins):
            guard let parent = superview else { return }
            topAnchor.constraint(equalTo: parent.topAnchor, constant: margins).isActive = true
            parent.bottomAnchor.constraint(equalTo: bottomAnchor, constant: margins).isActive = true
        }
        translatesAutoresizingMaskIntoConstraints = false
    }

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

    func alignCenter(axis: NSLayoutConstraint.Axis) {
        guard let parent = superview else { return }
        switch axis {
        case .horizontal:
            self.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        case .vertical:
            self.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
        }
    }

    func alignCenter() {
        alignCenter(axis: .horizontal)
        alignCenter(axis: .vertical)
    }
}
