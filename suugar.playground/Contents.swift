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
                $0.matchParentWidth(margins: 12)
                $0.matchParentHeight(margins: 8)
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

let navC = UINavigationController(rootViewController: SuugarViewController())
PlaygroundPage.current.liveView = navC
