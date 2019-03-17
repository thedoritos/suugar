import UIKit
import PlaygroundSupport

class SuugarViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "Suugar"
    }
}

let navC = UINavigationController(rootViewController: SuugarViewController())
PlaygroundPage.current.liveView = navC
