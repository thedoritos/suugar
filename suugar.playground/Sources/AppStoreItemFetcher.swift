import Foundation

public struct AppStoreItemFetcher {
    public let country: String
    public let limit: Int

    public init(country: String = "us", limit: Int = 10) {
        self.country = country
        self.limit = limit
    }

    public func fetch(onSuccess: @escaping ([AppStoreItem]) -> Void) {
        let url = URL(string: "https://itunes.apple.com/\(country)/rss/topgrossingapplications/limit=\(limit)/json")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []),
                let root = json as? Dictionary<String, Any>,
                let feed = root["feed"] as? Dictionary<String, Any>,
                let entry = feed["entry"] as? Array<Dictionary<String, Any>>
            else {
                return
            }

            let items: [AppStoreItem] = entry.map {
                guard
                    let imName = $0["im:name"] as? Dictionary<String, Any>,
                    let name = imName["label"] as? String,

                    let imArtist = $0["im:artist"] as? Dictionary<String, Any>,
                    let artist = imArtist["label"] as? String,

                    let imImage = $0["im:image"] as? Array<Dictionary<String, Any>>,
                    let image = imImage[1]["label"] as? String,
                    let imageURL = URL(string: image)
                else {
                    return AppStoreItem(title: "error", artist: "error", iconImageURL: URL(string: "")!)
                }

                return AppStoreItem(title: name, artist: artist, iconImageURL: imageURL)
            }
            onSuccess(items)
        }
        task.resume()
    }
}
