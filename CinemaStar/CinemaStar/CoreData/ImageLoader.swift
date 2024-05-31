//
//  ImageLoader.swift
//  CinemaStar
//
//  Created by Vermut xxx on 31.05.2024.
//

import SwiftUI

struct CachedImageView: View {
    @StateObject private var imageLoader = ImageLoader()
    let url: String

    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        } else {
            ProgressView()
                .onAppear {
                    imageLoader.loadImage(from: url)
                }
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    func loadImage(from url: String) {
        if let cachedImage = CoreDataStorageService.shared.fetchImageFromCache(url: url) {
            self.image = cachedImage
        } else {
            downloadImage(from: url)
        }
    }

    private func downloadImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        URLSession.shared.dataTask(with: imageURL) { data, _, _ in
            if let data = data, let downloadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = downloadedImage
                    CoreDataStorageService.shared.saveImageToCache(url: url, image: downloadedImage)
                }
            }
        }.resume()
    }
}
