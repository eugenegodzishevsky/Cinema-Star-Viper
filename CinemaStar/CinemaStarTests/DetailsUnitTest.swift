// DetailsUnitTest.swift
// Copyright © RoadMap. All rights reserved.

// import XCTest
// import Combine
// @testable import CinemaStar
//
// class DetailsInteractorTests: XCTestCase {
//    var interactor: DetailsInteractor!
//    var presenter: MockDetailsPresenter!
//    var networkService: MockNetworkRequest1!
//    var cancellables: Set<AnyCancellable>!
//
//    override func setUp() {
//        super.setUp()
//        presenter = MockDetailsPresenter()
//        networkService = MockNetworkRequest1()
//        interactor = DetailsInteractor(presenter: presenter)
//        cancellables = Set<AnyCancellable>()
//    }
//
//    override func tearDown() {
//        interactor = nil
//        presenter = nil
//        networkService = nil
//        cancellables = nil
//        super.tearDown()
//    }
//
//    func testFetchDetailsSuccess() {
//        // Создание массива стран
//        let mockCountry = CountryDTO(name: "Mock Country")
//        let countriesArray = [mockCountry]
//
//        // Создание массива языков
//        let mockLanguage = SpokenLanguageDTO(name: "Mock Language")
//        let languagesArray = [mockLanguage]
//
//        // Создание постера для фильма
//        let poster = PosterDTO(url: "mock_url")
//
//        // Создание рекомендованного фильма
//        let similarMoviePoster = PosterDTO(url: "mock_url")
//        let similarMovie = SimilarMovieDTO(name: "Mock Movie", poster: similarMoviePoster)
//
//        // Given
//        let expectation = XCTestExpectation(description: "Fetch details expectation")
//        let mockDetailsDTO = DetailsDTO(poster: DetailsPosterDTO(url: ""),
//                                        name: "Mock Movie",
//                                        rating: DetailsRatingDTO(kp: 8.0),
//                                        id: 123,
//                                        description: "Mock description",
//                                        year: 2024,
//                                        countries: countriesArray,
//                                        type: "Mock Type",
//                                        persons: [],
//                                        spokenLanguages: languagesArray,
//                                        similarMovies: [similarMovie])
//
//        let expectedDetails = DetailsOfFilmModel(dto: mockDetailsDTO)
//        networkService.stubbedResult = Just(mockDetailsDTO)
//            .setFailureType(to: Error.self)
//            .eraseToAnyPublisher()
//
//        // When
//        interactor.fetchDetails(id: 123)
//
//        // Then
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            XCTAssertEqual(self.presenter.details, expectedDetails)
//            XCTAssertEqual(self.presenter.state, .success(expectedDetails))
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 5.0)
//    }
//
//    // Add more test cases as needed
//
// }
//
//// Mock DetailsPresenter
// class MockDetailsPresenter: DetailsPresenterProtocol {
//    var detailsRouter: DetailsRouterProtocol?
//    var detailsInteractor: DetailsInteractorProtocol?
//    var details: DetailsOfFilmModel?
//    var state: StateView<DetailsOfFilmModel> = .initial
//    var isShowAlert: Bool = false
//    var isFavourite: Bool = false
//    var isfullInformationAboutFilm: Bool = false
//    var id: Int?
//
//    func getDetails(id: Int) {}
//
//    func convertTypeOfFilm() -> String {
//        return ""
//    }
// }
//
//// Mock NetworkRequest
// class MockNetworkRequest1: NetworkRequest {
//    func decode(_ data: Data) -> [CinemaStar.ListOfFilmsModel]? {}
//
//    func decodeDetails(_ data: Data) -> CinemaStar.DetailsOfFilmModel? {}
//
//    func execute(url: URL?) -> AnyPublisher<Data, Never> {}
//
//    var stubbedResult: AnyPublisher<CinemaStar.DetailsDTO, Error>?
//
//    func getFilm() -> AnyPublisher<[CinemaStar.ListOfFilmsModel]?, Never> {
//        return Just(nil).eraseToAnyPublisher()
//    }
//
//    func getDetail(id: Int) -> AnyPublisher<CinemaStar.DetailsOfFilmModel?, Never> {
//        if let stubbedResult = stubbedResult {
//            return stubbedResult
//                .map { CinemaStar.DetailsOfFilmModel(dto: $0) }
//                .replaceError(with: nil)
//                .eraseToAnyPublisher()
//        } else {
//            return Just(nil).eraseToAnyPublisher()
//        }
//    }
// }
