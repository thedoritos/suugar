//
//  UIView+Suugar.swift
//  Suugar
//
//  Created by thedoritos on 2019/03/24.
//

public typealias SuugarBlock<T: UIView> = (T) -> Void
public typealias SuugarFactory<T: UIView> = () -> T

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
        addSubview(view)
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
