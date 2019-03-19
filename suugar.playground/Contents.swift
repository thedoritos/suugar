import UIKit
import PlaygroundSupport

class AppTableViewCell: UITableViewCell {
    weak var titleView: MetaTextView!
    var titleLabel: UILabel { return titleView.valueLabel }

    weak var artistView: MetaTextView!
    var artistLabel: UILabel { return artistView.valueLabel }

    weak var appIconView: AppIconView!
    var iconImage: UIImageView { return appIconView.iconImage }

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
                $0.matchParentWidth(margins: 12)
                $0.matchParentHeight(margins: 8)
                $0.spacing = 8
                $0.alignment = .top

                appIconView = $0.composite()
                $0.vstack {
                    $0.spacing = 4

                    titleView = $0.composite {
                        $0.metaLabel.text = "Title:"
                    }
                    artistView = $0.composite {
                        $0.metaLabel.text = "Artist:"
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

let navC = UINavigationController(rootViewController: SuugarViewController())
PlaygroundPage.current.liveView = navC
