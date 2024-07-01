// MovieCardsCoreDataStorage.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

/// Кеш фильмов главного экрана
@objc(MovieCardsCoreDataStorage)
public class MovieCardsCoreDataStorage: NSManagedObject {}

public extension MovieCardsCoreDataStorage {
    @NSManaged var movieCards: Data?
}
