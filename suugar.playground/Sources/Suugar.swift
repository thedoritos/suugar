import UIKit

extension UIView {
    public func ui(block: (UIView) -> Void) {
        block(self)
    }

    @discardableResult
    public func view(block: (UIView) -> Void) -> UIView {
        let view = UIView()

        addSubview(view: view, block: block)
        return view
    }

    @discardableResult
    public func label(block: (UILabel) -> Void) -> UILabel {
        let label = UILabel()

        addSubview(view: label, block: block)
        return label
    }

    @discardableResult
    public func image(block: (UIImageView) -> Void) -> UIImageView {
        let image = UIImageView()

        addSubview(view: image, block: block)
        return image
    }

    @discardableResult
    public func table(block: (UITableView) -> Void) -> UITableView {
        let table = UITableView()

        addSubview(view: table, block: block)
        return table
    }

    @discardableResult
    public func stack(axis: NSLayoutConstraint.Axis = .horizontal, block: (UIStackView) -> Void) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis

        addSubview(view: stack, block: block)
        return stack
    }

    @discardableResult
    public func vstack(block: (UIStackView) -> Void) -> UIStackView {
        return stack(axis: .vertical, block: block)
    }

    private func addSubview<T: UIView>(view: T, block: (T) -> Void) {
        if let stackView = self as? UIStackView {
            stackView.addArrangedSubview(view)
            return block(view)
        }

        self.addSubview(view)
        return block(view)
    }

    public func size(width: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    public func size(height: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    public func size(width: CGFloat, height: CGFloat) {
        size(width: width)
        size(height: height)
    }

    public func matchParentWidth(margins: CGFloat = 0) {
        guard let parent = superview else { return }
        leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: margins).isActive = true
        parent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: margins).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    public func matchParentHeight(margins: CGFloat = 0) {
        guard let parent = superview else { return }
        topAnchor.constraint(equalTo: parent.topAnchor, constant: margins).isActive = true
        parent.bottomAnchor.constraint(equalTo: bottomAnchor, constant: margins).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    public func matchParent(margins: CGFloat = 0) {
        matchParentWidth(margins: margins)
        matchParentHeight(margins: margins)
    }
}

extension UIViewController {
    public func ui(block: (UIView) -> Void) {
        self.view.ui(block: block)
    }
}
