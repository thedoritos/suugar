import UIKit
import PlaygroundSupport

class AppTableViewCell: UITableViewCell {
    weak var nameLabel: UILabel!

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
            nameLabel = $0.label {
                $0.matchParent()
                $0.text = ""
                $0.numberOfLines = 0
                $0.textColor = UIColor.darkGray
                $0.font = UIFont.systemFont(ofSize: 17)
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

        addSubview(label)
        block(label)
        return label
    }

    @discardableResult
    func table(block: (UITableView) -> Void) -> UITableView {
        let table = UITableView()

        addSubview(table)
        block(table)
        return table
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
