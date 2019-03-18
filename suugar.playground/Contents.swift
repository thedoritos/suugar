import UIKit
import PlaygroundSupport

class SuugarViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top Grossing Applications"

        ui {
            $0.backgroundColor = UIColor.white
        }
    }
}

extension UIView {
    func ui(block: (UIView) -> Void) {
        block(self)
    }
}

extension UIViewController {
    func ui(block: (UIView) -> Void) {
        self.view.ui(block: block)
    }
}

let navC = UINavigationController(rootViewController: SuugarViewController())
PlaygroundPage.current.liveView = navC
