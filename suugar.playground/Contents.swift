import UIKit
import PlaygroundSupport

class AppTableViewCell: UITableViewCell {
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
        return cell
    }
}

extension UIView {
    func ui(block: (UIView) -> Void) {
        block(self)
    }

    @discardableResult
    func table(block: (UITableView) -> Void) -> UITableView {
        let table = UITableView()

        addSubview(table)
        block(table)
        return table
    }
}

extension UIViewController {
    func ui(block: (UIView) -> Void) {
        self.view.ui(block: block)
    }
}

let navC = UINavigationController(rootViewController: SuugarViewController())
PlaygroundPage.current.liveView = navC
