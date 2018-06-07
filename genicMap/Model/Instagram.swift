import UIKit

struct InstagramData: Codable {
  var data: [Data]
  struct Data: Codable {
    var user: User
    struct User: Codable {
      var id: String
      var full_name: String
      var profile_picture: String
    }
    var images: Images
    struct Images: Codable {
      var thumbnail: Thumbnail
      struct Thumbnail: Codable {
        var width: Int
        var height: Int
        var url: String
      }
      var standard_resolution: StandardResolution
      struct StandardResolution: Codable {
        var width: Int
        var height: Int
        var url: String
      }
    }
    var created_time: String
    var caption: Caption
    struct Caption: Codable {
      var text: String
    }
    var likes: Likes
    struct Likes: Codable {
      var count: Int
    }
    var tags: [String]
    var type: String
    var link: String
    var location: Location?
    struct Location: Codable {
      var latitude: Double?
      var longitude: Double?
      var name: String?
    }
  }
}

// TODO: For location API
//struct InstagramData: Codable {
//  var data: [Data]
//  struct Data: Codable {
//    var id: Int
//    var latitude: Double
//    var longitude: Double
//    var name: String
//  }
//}

var ACCESS_TOKEN: String!

struct Instagram {
  // TODO: For location API
  //  static func fetchInstagramData(lat: Double, lng: Double , completion: @escaping (InstagramData) -> Swift.Void) {
  static func fetchInstagramData(completion: @escaping (InstagramData) -> Swift.Void ) {
    let env = ProcessInfo.processInfo.environment
    ACCESS_TOKEN = env["ACCESS_TOKEN"]
    // TODO: For location API
    //    let url = "https://api.instagram.com/v1/locations/search?lat=\(lat)&lng=\(lng)&distance=750&access_token=\(ACCESS_TOKEN)"
    let url = "https://api.instagram.com/v1/users/self/media/recent/?access_token=\(ACCESS_TOKEN!)"
    print(url)
    guard let urlComponents = URLComponents(string: url) else {
      return
    }
    let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
      guard let jsonData = data else {
        return
      }
      do {
        let instagram = try JSONDecoder().decode(InstagramData.self, from: jsonData)
        completion(instagram)
      } catch {
        print(error.localizedDescription)
      }
    }
    task.resume()
  }
}
