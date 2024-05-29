// CoreDataService.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

/// Протокол кордата сервиса
protocol CoreDataStorageServiceProtocol {
    /// Создание карточeк фильма
    func createMovieCards(_ movieCards: FilmsDTO)
    /// Создание деталей фильма
    func createMovieDetails(_ movieDetails: DocsDTO, id: Int32)
    /// Получение карточек фильмов
    func fetchMovieCards() -> FilmsDTO
    /// Получение деталей фильма
    func fetchMovieDetails(_ id: Int32) -> DocsDTO?
    /// Обновление информации о фильмах
    func updateMovieCards(newMovieCards: FilmsDTO)
    /// Обновление информации деталей фильма
    func updateMovieDetailsCards(_ id: Int32, newMovieCard: DocsDTO)
    /// Удаление всех фильмов
    func deleteAllMovies()
}

/// Сервис для хранения в CoreData
final class CoreDataStorageService: CoreDataStorageServiceProtocol {
    // MARK: - Constants

    enum Constants {
        static let containerName = "CinemaStar"
        static let entityNameMovieCard = "MovieCardsCoreDataStorage"
        static let entityNameMovieDetails = "MovieDetailsCoreDataStorage"
    }

    static let shared = CoreDataStorageService()

    // MARK: - Private Properties

    private var context: NSManagedObjectContext
    private var persistentContainer: NSPersistentContainer

    // MARK: - Initializers

    private init() {
        persistentContainer = {
            let container = NSPersistentContainer(name: Constants.containerName)
            container.loadPersistentStores { description, error in
                if let error = error as NSError? {
                    print(error)
                } else {
                    print(description.url?.absoluteString ?? "")
                }
            }
            return container
        }()
        context = persistentContainer.viewContext
    }

    // MARK: - Public Methods

    func createMovieCards(_ movieCards: FilmsDTO) {
        let movieCardsCoreDataStorage = MovieCardsCoreDataStorage(context: context)

        if let storageMovieCards = getMovies() {
            if !storageMovieCards.isEmpty {
                updateMovieCards(newMovieCards: movieCards)
                print("Выполняется функция: \(#function)")
                return
            }
        }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(movieCards) {
            movieCardsCoreDataStorage.movieCards = encoded
            saveContext()
        }
    }

    func createMovieDetails(_ movieDetails: DocsDTO, id: Int32) {
        let movieDetailsCoreDataStorage = MovieDetailsCoreDataStorage(context: context)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(movieDetails) {
            movieDetailsCoreDataStorage.movieDetail = encoded
            movieDetailsCoreDataStorage.id = id
            print("Выполняется функция: \(#function)")
            saveContext()
        }
    }

    func fetchMovieCards() -> FilmsDTO {
        do {
            let decoder = JSONDecoder()
            guard let storageMovieCards = getMovies(),
                  let storageMovieCards = storageMovieCards.first?.movieCards,
                  let movieCard = try? decoder.decode(FilmsDTO.self, from: storageMovieCards)
            else { return FilmsDTO(docs: []) }
            print("Выполняется функция: \(#function)")
            return movieCard
        }
    }

    func fetchMovieDetails(_ id: Int32) -> DocsDTO? {
        do {
            let decoder = JSONDecoder()
            guard let storageMovieCards = getMovieDetails(),
                  let storageMovieCards = storageMovieCards.first(where: { $0.id == id })?.movieDetail,
                  let movieDetail = try? decoder.decode(DocsDTO.self, from: storageMovieCards)
            else { return nil
            }
            print("Выполняется функция: \(#function)")
            return movieDetail
        }
    }

    func updateMovieCards(newMovieCards: FilmsDTO) {
        guard let storageMovieCards = getMovies(),
              let storageMovieCards = storageMovieCards.first
        else { return }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(newMovieCards) {
            storageMovieCards.movieCards = encoded
            print("Выполняется функция: \(#function)")
            saveContext()
        }
    }

    func updateMovieDetailsCards(_ id: Int32, newMovieCard: DocsDTO) {
        guard let storageMovieDetailsCards = getMovieDetails(),
              let storageMovieDetailsCard = storageMovieDetailsCards.first(where: { $0.id == id })
        else {
            createMovieDetails(newMovieCard, id: id)
            return
        }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(newMovieCard) {
            storageMovieDetailsCard.movieDetail = encoded
            print("Выполняется функция: \(#function)")
            saveContext()
        }
    }

    func deleteAllMovies() {
        guard let storageMovieCards = getMovies() else { return }
        storageMovieCards.forEach { context.delete($0) }
        print("Выполняется функция: \(#function)")
        saveContext()
    }

    // MARK: - Private Methods

    private func saveContext() {
        print("Выполняется функция: \(#function)")
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
            }
        }
    }

    private func getMovies() -> [MovieCardsCoreDataStorage]? {
        try? context
            .fetch(NSFetchRequest<NSFetchRequestResult>(
                entityName: Constants
                    .entityNameMovieCard
            )) as? [MovieCardsCoreDataStorage]
    }

    private func getMovieDetails() -> [MovieDetailsCoreDataStorage]? {
        try? context
            .fetch(NSFetchRequest<NSFetchRequestResult>(
                entityName: Constants
                    .entityNameMovieDetails
            )) as? [MovieDetailsCoreDataStorage]
    }
}
