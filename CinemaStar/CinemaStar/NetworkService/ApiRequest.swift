// ApiRequest.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Протокол запроса
protocol NetworkRequest: AnyObject {
    /// Тип модели для парсинга
    associatedtype ModelType
    /// Функция декодирования
    func decode(_ data: Data) -> ModelType?
    /// Функция запроса
    func execute(withCompletion completion: @escaping (Result<ModelType?, Error>) -> Void)
}

// MARK: - Добавление функции загрузки данных

extension NetworkRequest {
    func load(_ url: URL?, withCompletion completion: @escaping (Result<ModelType?, Error>) -> Void) {
        guard let url = url else {
            DispatchQueue.main.async { completion(.failure(NetworkError.notValidURL)) }
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(KeyChainService().getAPIKey(), forHTTPHeaderField: "X-API-KEY")
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, _ in
            guard let data = data, let value = self?.decode(data) else {
                print(String(decoding: data ?? Data(), as: UTF8.self))
                DispatchQueue.main.async { completion(.failure(NetworkError.nilData)) }
                return
            }
            DispatchQueue.main.async { completion(.success(value)) }
        }
        task.resume()
    }
}

/// Класс запроса данных фильма
final class APIRequest<Resource: APIResource> {
    // MARK: - Public Properties

    let resource: Resource

    // MARK: - Initializers

    init(resource: Resource) {
        self.resource = resource
    }
}

// MARK: - APIRequest + NetworkRequest

extension APIRequest: NetworkRequest {
    func decode(_ data: Data) -> Resource.ModelType? {
        let decoder = JSONDecoder()
        return try? decoder.decode(Resource.ModelType.self, from: data)
    }

    func execute(withCompletion completion: @escaping (Result<Resource.ModelType?, any Error>) -> Void) {
        load(resource.url, withCompletion: completion)
    }
}
