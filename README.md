# Suugar

Suugar (pronounced as sugar) is an experimental project to build UI for iOS application by code of Swift.

# Concepts

## Readable Hierarchy

Suugar allows you to write UI hierarchy with nested calls of methods.

```swift
ui {
    $0.stack {
        $0.image {
            $0.image = UIImage(named: "ic_hello")
        }
        $0.label {
            $0.text = "Hello, Suugar!!"
        }
    }
}
```

## Regular UIKit Components

All of nests are just regular method calls, and each `$0` is standard UIKit component.
So, you can write code with UIKit just like you do usually.

```swift
ui {
    // $0 is UIView
    $0.backgroundColor = UIColor.white

    $0.table {
        // $0 is UITableView
        $0.estimatedRowHeight = UITableView.automaticDimension
        $0.register(HelloTableViewCell.self, forCellReuseIdentifier: "cell")
        $0.dataSource = self
    }
}
```

## Easily Reusable Views

If you have custom views already using, you can easily integrate it into the hierarchy.

```swift
class HelloView: UIStackView {
    // TODO: Override init methods to call render

    private func render() {
        ui {
            $0.image {
                $0.image = UIImage(named: "ic_hello")
            }
            $0.label {
                $0.text = "Hello, Again!!"
            }
        }
    }
}
```

```swift
ui {
    // By specifying the type
    $0.composite(HelloView.self)

    // Or ask compiler to do it
    let view: HelloView = $0.composite()
}
```
