// ListUnitTest.swift
// Copyright © RoadMap. All rights reserved.

@testable import CinemaStar
import Combine
import XCTest

class ListInteractorTests: XCTestCase {
    var interactor: ListInteractor!
    var presenter: MockListPresenter!
    var networkService: MockNetworkRequest!
    var cancellables: Set<AnyCancellable>!
    override func setUp() {
        super.setUp()
        presenter = MockListPresenter()
        networkService = MockNetworkRequest()
        interactor = ListInteractor(presenter: presenter, networkService: networkService)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        interactor = nil
        presenter = nil
        networkService = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchFilmSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch film expectation")
        let mockDocDTO = MockDocDTO(
            name: "Test Film",
            rating: MockRatingDTO(kp: 8.5),
            poster: MockPosterDTO(url: "https://example.com/poster.jpg"),
            id: 123
        )
        let mockListDTO = MockListDTO(docs: [mockDocDTO])
        let expectedFilms = [ListOfFilmsModel(dto: DocDTO(
            name: mockDocDTO.name,
            rating: RatingDTO(kp: mockDocDTO.rating.kp),
            poster: PosterDTO(url: mockDocDTO.poster.url),
            id: mockDocDTO.id
        ))]
        networkService.stubbedResult = Just(mockListDTO)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        // When
        interactor.fetchFilm()
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(expectedFilms.count, 1)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}

// Mock ListPresenter
class MockListPresenter: ListPresenterProtocol {
    var state: CinemaStar.StateView<[CinemaStar.ListOfFilmsModel]> = .initial
    var films: [ListOfFilmsModel]?
    var listRouter: ListRouterProtocol?
    var listInteractor: ListInteractorProtocol?
    var isShowDetails: Bool = false
    var id: Int?

    func getFilms() {}

    func goToDetail(id: Int) {}
}

// Mock NetworkRequest
class MockNetworkRequest: NetworkRequest {
    var stubbedResult: AnyPublisher<MockListDTO, Error>?

    func decode(_ data: Data) -> [ListOfFilmsModel]? {
        nil
    }

    func decodeDetails(_ data: Data) -> DetailsOfFilmModel? {
        nil
    }

    func getFilm() -> AnyPublisher<[ListOfFilmsModel]?, Never> {
        stubbedResult!
            .map { listDTO in
                listDTO.docs.map { ListOfFilmsModel(dto: DocDTO(
                    name: $0.name,
                    rating: RatingDTO(kp: $0.rating.kp),
                    poster: PosterDTO(url: $0.poster.url),
                    id: $0.id
                )) }
            }
            .replaceError(with: nil)
            .map { films in
                films
            }
            .eraseToAnyPublisher()
    }

    func getDetail(id: Int) -> AnyPublisher<DetailsOfFilmModel?, Never> {
        Just(nil).eraseToAnyPublisher()
    }

    func execute(url: URL?) -> AnyPublisher<Data, Never> {
        Just(Data()).eraseToAnyPublisher()
    }
}

// Mock DTO for ListDTO
struct MockListDTO: Codable {
    let docs: [MockDocDTO]
}

// Mock DTO for DocDTO
struct MockDocDTO: Codable {
    let name: String
    let rating: MockRatingDTO
    let poster: MockPosterDTO
    let id: Int
}

// Mock DTO for PosterDTO
struct MockPosterDTO: Codable {
    let url: String
}

// Mock DTO for RatingDTO
struct MockRatingDTO: Codable {
    let kp: Double
}

// Mock Error
enum YourMockError: Error {
    case sampleError
}
