// CoreDtataService.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation
import SwiftUI

/// Протокол кордата сервиса
protocol CoreDataStorageServiceProtocol {
    func createMovieCards(_ movieCards: ListDTO)
    func createMovieDetails(_ movieDetails: DetailsDTO, id: Int32)
    func fetchMovieCards() -> ListDTO?
    func fetchMovieDetails(_ id: Int32) -> DetailsDTO?
    func updateMovieCards(newMovieCards: ListDTO)
    func updateMovieDetailsCards(_ id: Int32, newMovieCard: DetailsDTO)
    func deleteAllMovies()
}

/// Сервис для хранения в CoreData
final class CoreDataStorageService: CoreDataStorageServiceProtocol {
    // MARK: - Constants

    enum Constants {
        static let containerName = Strings.containerName
        static let entityNameMovieCard = Strings.entityNameMovieCard
        static let entityNameMovieDetails = Strings.entityNameMovieDetails
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
                    print("Ошибка при загрузке persistent stores: \(error), \(error.userInfo)")
                } else {
                    print(
                        "persistent stores успешно загружены, URL: \(description.url?.absoluteString ?? "URL не найден")"
                    )
                }
            }
            return container
        }()
        context = persistentContainer.viewContext
    }

    // MARK: - Public Methods

    func createMovieCards(_ movieCards: ListDTO) {
        print("Creating movie cards...")
        let movieCardsCoreDataStorage = MovieCardsCoreDataStorage(context: context)

        if let storageMovieCards = getMovies(), !storageMovieCards.isEmpty {
            updateMovieCards(newMovieCards: movieCards)
            return
        }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(movieCards) {
            movieCardsCoreDataStorage.movieCards = encoded
            saveContext()
            print("Movie cards created and saved to CoreData.")
        }
    }

    func createMovieDetails(_ movieDetails: DetailsDTO, id: Int32) {
        print("Creating movie details for id \(id)...")
        guard fetchMovieDetails(id) == nil else {
            print("Movie details already exist for id \(id). Skipping creation.")
            return
        }

        let movieDetailsCoreDataStorage = MovieDetailsCoreDataStorage(context: context)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(movieDetails) {
            movieDetailsCoreDataStorage.movieDetail = encoded
            movieDetailsCoreDataStorage.id = id
            saveContext()
            print("Movie details created and saved to CoreData.")
        }
    }

    func fetchMovieCards() -> ListDTO? {
        print("Fetching movie cards...")
        let decoder = JSONDecoder()
        guard let storageMovieCards = getMovies(),
              let storageMovieCards = storageMovieCards.first?.movieCards,
              let movieCard = try? decoder.decode(ListDTO.self, from: storageMovieCards)
        else {
            print("No movie cards found.")
            return ListDTO(docs: [])
        }
        print("Movie cards fetched from CoreData.")
        return movieCard
    }

    func fetchMovieDetails(_ id: Int32) -> DetailsDTO? {
        print("Fetching movie details for id \(id)...")
        let decoder = JSONDecoder()
        guard let storageMovieDetails = getMovieDetails()?.first(where: { $0.id == id }),
              let movieDetailData = storageMovieDetails.movieDetail,
              let movieDetail = try? decoder.decode(DetailsDTO.self, from: movieDetailData)
        else {
            print("No movie details found for id \(id).")
            return nil
        }
        print("Movie details fetched from CoreData for id \(id).")
        return movieDetail
    }

    func updateMovieCards(newMovieCards: ListDTO) {
        print("Updating movie cards...")
        guard let storageMovieCards = getMovies(),
              let storageMovieCards = storageMovieCards.first else { return }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(newMovieCards) {
            storageMovieCards.movieCards = encoded
            saveContext()
            print("Movie cards updated in CoreData.")
        }
    }

    func updateMovieDetailsCards(_ id: Int32, newMovieCard: DetailsDTO) {
        print("Updating movie details for id \(id)...")
        guard let storageMovieDetailsCards = getMovieDetails(),
              let storageMovieDetailsCard = storageMovieDetailsCards.first(where: { $0.id == id })
        else {
            print("No existing movie details found for id \(id), creating new details.")
            createMovieDetails(newMovieCard, id: id)
            return
        }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(newMovieCard) {
            storageMovieDetailsCard.movieDetail = encoded
            saveContext()
            print("Movie details updated in CoreData for id \(id).")
        }
    }

//    func deleteAllMovies() {
//        print("Deleting all movies from CoreData...")
//        guard let storageMovieCards = getMovies() else { return }
//        storageMovieCards.forEach { context.delete($0) }
//        saveContext()
//        print("All movies deleted from CoreData.")
//    }

    func deleteAllMovies() {
        print("Deleting all movies from CoreData...")
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "MovieCard")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try persistentContainer.viewContext.execute(batchDeleteRequest)
            print("All movies deleted from CoreData.")
        } catch {
            print("Failed to delete movies: \(error)")
        }
    }

    // MARK: - Private Methods

    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("Context successfully saved.")
            } catch {
                context.rollback()
                print("Failed to save context, changes rolled back.")
            }
        }
    }

    private func getMovies() -> [MovieCardsCoreDataStorage]? {
        print("Fetching MovieCardsCoreDataStorage from CoreData...")
        return try? context
            .fetch(NSFetchRequest<NSFetchRequestResult>(
                entityName: Constants.entityNameMovieCard
            )) as? [MovieCardsCoreDataStorage]
    }

    private func getMovieDetails() -> [MovieDetailsCoreDataStorage]? {
        print("Fetching MovieDetailsCoreDataStorage from CoreData...")
        return try? context
            .fetch(NSFetchRequest<NSFetchRequestResult>(
                entityName: Constants.entityNameMovieDetails
            )) as? [MovieDetailsCoreDataStorage]
    }
}

extension CoreDataStorageService {
    func saveImageToCache(url: String, image: UIImage) {
        let fetchRequest: NSFetchRequest<ImageCache> = ImageCache.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "url == %@", url)

        do {
            let results = try context.fetch(fetchRequest)
            let imageCache: ImageCache

            if let existingImageCache = results.first {
                imageCache = existingImageCache
            } else {
                imageCache = ImageCache(context: context)
                imageCache.url = url
            }

            imageCache.imageData = image.pngData()
            saveContext()
        } catch {
            print("Failed to save image to Core Data: \(error)")
        }
    }

    func fetchImageFromCache(url: String) -> UIImage? {
        let fetchRequest: NSFetchRequest<ImageCache> = ImageCache.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "url == %@", url)

        do {
            let results = try context.fetch(fetchRequest)
            if let imageCache = results.first, let imageData = imageCache.imageData {
                return UIImage(data: imageData)
            }
        } catch {
            print("Failed to fetch image from Core Data: \(error)")
        }
        return nil
    }
}
