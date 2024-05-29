// VoidHandler.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Псевдонимы для кложур
public typealias VoidHandler = () -> Void
public typealias BoolHandler = (Bool) -> Void
public typealias StringHandler = (String) -> Void
public typealias DateHandler = (Date) -> Void
public typealias OptionalDateHandler = (Date?) -> Void
public typealias DataHandler = (Data) -> Void
typealias MovieCardHandler = (MovieData) -> Void
