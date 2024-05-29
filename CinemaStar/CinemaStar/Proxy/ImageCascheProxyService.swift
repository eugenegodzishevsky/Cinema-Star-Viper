// ImageCascheProxyService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Прокси сервис кеширования данных
final class ImageCacheProxyService {
    enum Constants {
        static let imageCacheFolderName = "ImageCache"
    }

    // MARK: - Public Properties

    private let networkService: any NetworkRequest
    private var cacheImageFolderURL: URL?
    private var fileManager: FileManager
    var url: URL?

    // MARK: - Initializers

    init(networkService: any NetworkRequest, fileManager: FileManager) {
        self.networkService = networkService
        self.fileManager = fileManager
        setupFileManager()
    }

    // MARK: - Private Methods

    private func setupFileManager() {
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        cacheImageFolderURL = url.appendingPathComponent(Constants.imageCacheFolderName)
        print(cacheImageFolderURL ?? "")
        guard let cacheImageFolderURL = cacheImageFolderURL,
              !fileManager.fileExists(atPath: cacheImageFolderURL.path()) else { return }
        do {
            try fileManager.createDirectory(at: cacheImageFolderURL, withIntermediateDirectories: true)
        } catch { return }
    }
}

// MARK: - CascheProxyService + NetworkRequest

extension ImageCacheProxyService: NetworkRequest {
    func decode(_ data: Data) -> Data? {
        networkService.decode(data) as? Data
    }

    func execute(withCompletion completion: @escaping (Result<Data?, any Error>) -> Void) {
        guard let imageNetworkURL = url,
              let cacheImageFolderURL = cacheImageFolderURL else { return }

        let imageName = imageNetworkURL.pathComponents[imageNetworkURL.pathComponents.count - 2] + imageNetworkURL
            .pathComponents[imageNetworkURL.pathComponents.count - 1]
        var imageFilePath = cacheImageFolderURL.appendingPathComponent(imageName).path()
        imageFilePath.append(".png")
        if fileManager.fileExists(atPath: imageFilePath) {
            guard let imageData = fileManager.contents(atPath: imageFilePath) else { return }
            completion(.success(imageData))
        } else {
            load(url) { [weak self] result in
                switch result {
                case let .success(data):
                    self?.fileManager.createFile(atPath: imageFilePath, contents: data)
                    completion(.success(data))
                default:
                    completion(.failure(NetworkError.networkError(0)))
                }
            }
        }
    }
}
