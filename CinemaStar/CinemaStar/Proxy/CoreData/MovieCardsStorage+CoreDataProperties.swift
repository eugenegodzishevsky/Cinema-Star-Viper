// MovieCardsStorage+CoreDataProperties.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

/// Кеш фильмов главного экрана
@objc(MovieCardsCoreDataStorage1)
public class MovieCardsCoreDataStorage1: NSManagedObject {}

public extension MovieCardsCoreDataStorage1 {
    @NSManaged var movieCards: Data?
}
