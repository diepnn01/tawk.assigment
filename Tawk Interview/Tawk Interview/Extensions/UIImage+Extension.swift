//
//  UIImage+Extension.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 22/05/2022.
//

import UIKit
extension UIImageView {
    func loadImage(url: String) {
        self.image = UIImage(named: "default_avatar")
        guard let url = URL(string: url) else {return}
        let cachedFile = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first!
            .appendingPathComponent(
                url.lastPathComponent,
                isDirectory: false
            )
        if let data = try? Data(contentsOf: cachedFile) {
            self.image = UIImage(data: data)
            return
        }
        
        // If the image does not exist in the cache,
        // download the image to the cache
        download(url: url, toFile: cachedFile) { (error) in
            if let data = try? Data(contentsOf: cachedFile) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
    
    fileprivate func download(url: URL, toFile file: URL, completion: @escaping (Error?) -> Void) {
        // Download the remote URL to a file
        let task = URLSession.shared.downloadTask(with: url) {
            (tempURL, response, error) in
            // Early exit on error
            guard let tempURL = tempURL else {
                completion(error)
                return
            }

            do {
                // Remove any existing document at file
                if FileManager.default.fileExists(atPath: file.path) {
                    try FileManager.default.removeItem(at: file)
                }

                // Copy the tempURL to file
                try FileManager.default.copyItem(
                    at: tempURL,
                    to: file
                )

                completion(nil)
            }

            // Handle potential file system errors
            catch let fileError {
                completion(error)
            }
        }

        // Start the download
        task.resume()
    }
}
