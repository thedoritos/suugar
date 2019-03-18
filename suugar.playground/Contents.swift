import UIKit
import PlaygroundSupport

class AppTableViewCell: UITableViewCell {
    weak var titleLabel: UILabel!
    weak var artistLabel: UILabel!
    weak var iconImage: UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    private func setUp() {
        ui {
            $0.stack {
                $0.matchParent(margins: 8)
                $0.spacing = 8
                $0.alignment = .top

                $0.view {
                    $0.layer.borderColor = UIColor.init(white: 0.81, alpha: 1).cgColor
                    $0.layer.borderWidth = 1
                    $0.layer.cornerRadius = 16
                    $0.layer.masksToBounds = true

                    iconImage = $0.image {
                        $0.matchParent()
                        $0.size(width: 75, height: 75)
                        $0.contentMode = .scaleAspectFit
                        $0.backgroundColor = UIColor.init(white: 0.96, alpha: 1)
                    }
                }
                $0.vstack {
                    $0.spacing = 4

                    $0.stack {
                        $0.spacing = 8

                        $0.label {
                            $0.size(width: 38)
                            $0.text = "Title:"
                            $0.textAlignment = .right
                            $0.font = UIFont.systemFont(ofSize: 12)
                            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
                        }
                        titleLabel = $0.label {
                            $0.text = ""
                            $0.numberOfLines = 0
                            $0.textColor = UIColor.darkGray
                            $0.font = UIFont.systemFont(ofSize: 17)
                            $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
                        }
                    }
                    $0.stack {
                        $0.spacing = 8

                        $0.label {
                            $0.size(width: 38)
                            $0.text = "Artist:"
                            $0.textAlignment = .right
                            $0.font = UIFont.systemFont(ofSize: 12)
                            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
                        }
                        artistLabel = $0.label {
                            $0.text = ""
                            $0.numberOfLines = 0
                            $0.textColor = UIColor.darkGray
                            $0.font = UIFont.systemFont(ofSize: 17)
                            $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
                        }
                    }
                }
            }
        }
    }
}

class SuugarViewController: UIViewController, UITableViewDataSource {
    weak var table: UITableView!

    var items: [AppStoreItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top Grossing Applications"

        ui {
            $0.backgroundColor = UIColor.white
            table = $0.table {
                $0.matchParent()
                $0.estimatedRowHeight = UITableView.automaticDimension
                $0.register(AppTableViewCell.self, forCellReuseIdentifier: "cell")
                $0.dataSource = self
            }
        }

        let fetcher = AppStoreItemFetcher()
        fetcher.fetch { [weak self] items in
            DispatchQueue.main.async {
                self?.items = items
                self?.table.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AppTableViewCell

        let item = items[indexPath.row]
        cell.titleLabel.text = item.title
        cell.artistLabel.text = item.artist
        cell.iconImage.image = UIImage(data: try! Data(contentsOf: item.iconImageURL))

        return cell
    }
}

extension UIView {
    func ui(block: (UIView) -> Void) {
        block(self)
    }

    @discardableResult
    func view(block: (UIView) -> Void) -> UIView {
        let view = UIView()

        addSubview(view: view, block: block)
        return view
    }

    @discardableResult
    func label(block: (UILabel) -> Void) -> UILabel {
        let label = UILabel()

        addSubview(view: label, block: block)
        return label
    }

    @discardableResult
    func image(block: (UIImageView) -> Void) -> UIImageView {
        let image = UIImageView()

        addSubview(view: image, block: block)
        return image
    }

    @discardableResult
    func table(block: (UITableView) -> Void) -> UITableView {
        let table = UITableView()

        addSubview(view: table, block: block)
        return table
    }

    @discardableResult
    func stack(axis: NSLayoutConstraint.Axis = .horizontal, block: (UIStackView) -> Void) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis

        addSubview(view: stack, block: block)
        return stack
    }

    @discardableResult
    func vstack(block: (UIStackView) -> Void) -> UIStackView {
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

extension UIViewController {
    func ui(block: (UIView) -> Void) {
        self.view.ui(block: block)
    }
}

let navC = UINavigationController(rootViewController: SuugarViewController())
PlaygroundPage.current.liveView = navC
