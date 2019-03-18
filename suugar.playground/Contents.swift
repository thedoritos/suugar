import UIKit
import PlaygroundSupport

class AppTableViewCell: UITableViewCell {
    weak var nameLabel: UILabel!
    weak var artistLabel: UILabel!

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
            $0.vstack {
                $0.matchParent()
                $0.spacing = 4

                $0.stack {
                    $0.spacing = 8

                    $0.label {
                        $0.text = "Title:"
                        $0.textAlignment = .right
                        $0.font = UIFont.systemFont(ofSize: 12)
                        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
                    }
                    nameLabel = $0.label {
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
        cell.nameLabel.text = item.title
        cell.artistLabel.text = item.artist

        return cell
    }
}

extension UIView {
    func ui(block: (UIView) -> Void) {
        block(self)
    }

    @discardableResult
    func label(block: (UILabel) -> Void) -> UILabel {
        let label = UILabel()

        addSubview(view: label, block: block)
        return label
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
