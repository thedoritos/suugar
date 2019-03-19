import UIKit

public class AppIconView: UIView {
    public weak var iconImage: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUp()
    }

    private func setUp() {
        ui {
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
    }
}
