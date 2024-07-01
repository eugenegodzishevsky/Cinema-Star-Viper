// MovieDetailsCoreDataStorage+CoreDataProperties 23.31.54.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

/// Кеш фильмов детального экрана
@objc(MovieDetailsCoreDataStorage)
public class MovieDetailsCoreDataStorage: NSManagedObject {}

public extension MovieDetailsCoreDataStorage {
    @NSManaged var movieDetail: Data?
    @NSManaged var id: Int32
}
