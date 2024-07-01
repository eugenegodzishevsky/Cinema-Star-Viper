// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation

/// Протокол NetworkRequest
protocol NetworkRequest: AnyObject {
    /// Декодирование информации о фильме
    func decode(_ data: Data) -> [ListOfFilmsModel]?
    /// Декодирование информации о деталях фильма
    func decodeDetails(_ data: Data) -> DetailsOfFilmModel?
    /// Получение фильма
    func getFilm() -> AnyPublisher<[ListOfFilmsModel]?, Never>
    /// Получение деталей
    func getDetail(id: Int) -> AnyPublisher<DetailsOfFilmModel?, Never>
    /// Получение картинки
    func execute(url: URL?) -> AnyPublisher<Data, Never>
}

/// Сервис для получения данных
final class NetworkService: NetworkRequest {
    // MARK: - Types

    typealias ModelType = ListOfFilmsModel
    typealias ModelTypeDetails = DetailsOfFilmModel

    // MARK: - Private Properties

    private let resource = FilmsResourse()
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Public Methods

    func execute(url: URL?) -> AnyPublisher<Data, Never> {
        guard let url = url else {
            return Just(Data()).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .replaceError(with: Data())
            .eraseToAnyPublisher()
    }

    func decode(_ data: Data) -> [ListOfFilmsModel]? {
        let decoder = JSONDecoder()
        let wrapper = try? decoder.decode(ListDTO.self, from: data)
        let res = wrapper?.docs.map { ListOfFilmsModel(dto: $0.self) }
        return res
    }

    func decodeDetails(_ data: Data) -> DetailsOfFilmModel? {
        let decoder = JSONDecoder()
        let wrapper = try? decoder.decode(DetailsDTO.self, from: data)
        guard let wrapper = wrapper else { return nil }
        let res = DetailsOfFilmModel(dto: wrapper)
        return res
    }

    func getFilm() -> AnyPublisher<[ListOfFilmsModel]?, Never> {
        guard let url = resource.url else {
            return Just(nil).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ListDTO.self, decoder: JSONDecoder())
            .map { $0.docs.map { ListOfFilmsModel(dto: $0) } }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }

    func getDetail(id: Int) -> AnyPublisher<DetailsOfFilmModel?, Never> {
        let request = FilmsResourse(id: id)
        guard let url = request.urlDetails else {
            return Just(nil).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: DetailsDTO.self, decoder: JSONDecoder())
            .map { DetailsOfFilmModel(dto: $0) }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
}
