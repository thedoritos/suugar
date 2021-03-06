//
//  UIView+Suugar.swift
//  Suugar
//
//  Created by thedoritos on 2019/03/24.
//

import UIKit

public typealias SuugarBlock<T: UIView> = (T) -> Void
public typealias SuugarFunc<T: UIView, U> = (T) -> U
public typealias SuugarFactory<T: UIView> = () -> T

public extension UIAppearance {
    @discardableResult
    func apply(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }

    @discardableResult
    func apply<T>(_ map: (Self) -> T) -> T {
        return map(self)
    }
}

public extension UIViewController {
    func ui(_ block: SuugarBlock<UIView>) {
        block(self.view)
    }
}

public extension UIView {
    func ui(_ block: SuugarBlock<UIView>) {
        block(self)
    }

    func include(_ block: SuugarBlock<UIView>) {
        block(self)
    }
}

public extension UIView {
    private func addSubview<T: UIView>(factory: SuugarFactory<T>, block: SuugarBlock<T>) -> T {
        let view = factory()

        if let stackView = self as? UIStackView {
            stackView.addArrangedSubview(view)
        } else {
            addSubview(view)
        }

        block(view)
        return view
    }

    private func addSubview<T: UIView>(block: SuugarBlock<T>) -> T {
        return addSubview(factory: { T() }, block: block)
    }

    @discardableResult
    func view(block: SuugarBlock<UIView> = { _ in }) -> UIView {
        return addSubview(block: block)
    }

    @discardableResult
    func label(block: SuugarBlock<UILabel> = { _ in }) -> UILabel {
        return addSubview(block: block)
    }

    @discardableResult
    func button(block: SuugarBlock<UIButton> = { _ in }) -> UIButton {
        return addSubview(block: block)
    }

    @discardableResult
    public func stack(axis: NSLayoutConstraint.Axis = .horizontal, block: (UIStackView) -> Void) -> UIStackView {
        let factory: SuugarFactory<UIStackView> = {
            let view = UIStackView()
            view.axis = axis
            return view
        }
        return addSubview(factory: factory, block: block)
    }

    @discardableResult
    public func vstack(block: (UIStackView) -> Void) -> UIStackView {
        return stack(axis: .vertical, block: block)
    }

    @discardableResult
    func scrollView(block: SuugarBlock<UIScrollView> = { _ in }) -> UIScrollView {
        return addSubview(block: block)
    }

    @discardableResult
    func table(block: SuugarBlock<UITableView> = { _ in }) -> UITableView {
        return addSubview(block: block)
    }

    @discardableResult
    func collection(block: SuugarBlock<UICollectionView> = { _ in }) -> UICollectionView {
        let factory: SuugarFactory<UICollectionView> = {
            return UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        }
        return addSubview(factory: factory, block: block)
    }

    @discardableResult
    func composite<T: UIView>(block: SuugarBlock<T> = { _ in }) -> T {
        return addSubview(block: block)
    }

    @discardableResult
    func composite<T: UIView>(of type: T.Type, block: SuugarBlock<T> = { _ in }) -> T {
        return addSubview(block: block)
    }

    @discardableResult
    func composite<T: UIView>(of instance: T, block: SuugarBlock<T> = { _ in }) -> T {
        return addSubview(factory: { instance }, block: block)
    }

    @discardableResult
    func composite<T: UIView>(by factory: SuugarFactory<T>, block: SuugarBlock<T> = { _ in }) -> T {
        return addSubview(factory: factory, block: block)
    }
}
