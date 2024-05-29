// MovieDetailsCoreDataStorage+CoreDataProperties.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

/// Кеш фильмов детального экрана
@objc(MovieDetailsCoreDataStorage1)
public class MovieDetailsCoreDataStorage1: NSManagedObject {}

public extension MovieDetailsCoreDataStorage1 {
    @NSManaged var movieDetail: Data?
    @NSManaged var id: Int32
}
