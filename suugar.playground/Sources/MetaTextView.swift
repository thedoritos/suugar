import UIKit

public class MetaTextView: UIView {
    public weak var metaLabel: UILabel!
    public weak var valueLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    private func setUp() {
        ui {
            $0.stack {
                $0.matchParent()
                $0.spacing = 8

                metaLabel = $0.label {
                    $0.size(width: 38)
                    $0.text = ":"
                    $0.textAlignment = .right
                    $0.font = UIFont.systemFont(ofSize: 12)
                    $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
                }
                valueLabel = $0.label {
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
