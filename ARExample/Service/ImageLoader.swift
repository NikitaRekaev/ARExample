//  ImageLoader.swift
//  Nikita Rekaev 13.04.2023

import UIKit

final class ImageLoader {

    // MARK: - Properties

    static let shared = ImageLoader()

    // MARK: - Internal methods

    func downloadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.downloadTask(with: url) { (image, response, error) in
            guard let image = image, error == nil else { return }

            do {
                let imageData = try Data(contentsOf: image)
                let image = UIImage(data: imageData)

                completion(image)
            } catch let error as NSError {
                print("Error reading downloaded file: \(error)")
            }
        }

        task.resume()
    }

}
