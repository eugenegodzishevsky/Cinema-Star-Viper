// Strings+Generated.swift
// Copyright © RoadMap. All rights reserved.

// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
enum Strings {
    /// Актеры и съемочная группа
    static let actorsText = Strings.tr("Localizable", "actorsText", fallback: "Актеры и съемочная группа ")
    /// transform.translation.x
    static let animation = Strings.tr("Localizable", "animation", fallback: "transform.translation.x")
    /// api.kinopoisk.dev
    static let apiKinopoiskDev = Strings.tr("Localizable", "ApiKinopoiskDev", fallback: "api.kinopoisk.dev")
    /// 92JSXDT-SVE4DKZ-KWA35X9-K3H52VA
    static let apiToken = Strings.tr("Localizable", "apiToken", fallback: "92JSXDT-SVE4DKZ-KWA35X9-K3H52VA")
    /// arrow
    static let arrow = Strings.tr("Localizable", "arrow", fallback: "arrow")
    /// arrow2
    static let arrow2 = Strings.tr("Localizable", "arrow2", fallback: "arrow2")
    /// backArrow
    static let backArrow = Strings.tr("Localizable", "backArrow", fallback: "backArrow")
    ///  CINEMA STAR
    static let cinemaStar = Strings.tr("Localizable", "cinemaStar", fallback: " CINEMA STAR")
    /// Localizable.strings
    ///   CinemaStar
    ///
    ///   Created by Vermut xxx on 31.05.2024.
    static let containerName = Strings.tr("Localizable", "containerName", fallback: "CacheDataModel")
    /// MovieCardsCoreDataStorage
    static let entityNameMovieCard = Strings.tr(
        "Localizable",
        "entityNameMovieCard",
        fallback: "MovieCardsCoreDataStorage"
    )
    /// MovieDetailsCoreDataStorage
    static let entityNameMovieDetails = Strings.tr(
        "Localizable",
        "entityNameMovieDetails",
        fallback: "MovieDetailsCoreDataStorage"
    )
    /// Failure data
    static let failureText = Strings.tr("Localizable", "failureText", fallback: "Failure data")
    /// favourite
    static let fav = Strings.tr("Localizable", "fav", fallback: "favourite")
    /// favourites2
    static let fav2 = Strings.tr("Localizable", "fav2", fallback: "favourites2")
    /// Фильм
    static let film = Strings.tr("Localizable", "film", fallback: "Фильм")
    /// Функционал в разработке:(
    static let funcInDevelop = Strings.tr("Localizable", "funcInDevelop", fallback: "Функционал в разработке:(")
    /// история
    static let history = Strings.tr("Localizable", "history", fallback: "история")
    /// https
    static let https = Strings.tr("Localizable", "https", fallback: "https")
    /// Язык
    static let lang = Strings.tr("Localizable", "lang", fallback: "Язык")
    /// Смотрите также
    static let lookMore = Strings.tr("Localizable", "lookMore", fallback: "Смотрите также")
    /// Смотреть
    static let lookText = Strings.tr("Localizable", "lookText", fallback: "Смотреть")
    /// /v1.4/movie/
    static let movie = Strings.tr("Localizable", "movie", fallback: "/v1.4/movie/")
    /// /v1.4/movie/search
    static let movieSearch = Strings.tr("Localizable", "movieSearch", fallback: "/v1.4/movie/search")
    /// Упс!
    static let ops = Strings.tr("Localizable", "ops", fallback: "Упс!")
    /// query
    static let query = Strings.tr("Localizable", "query", fallback: "query")
    /// Сериал
    static let serial = Strings.tr("Localizable", "serial", fallback: "Сериал")
    /// shimmerAnimation
    static let shimmerAnimation = Strings.tr("Localizable", "shimmerAnimation", fallback: "shimmerAnimation")
    /// ⭐️
    static let star = Strings.tr("Localizable", "star", fallback: "⭐️")
    /// Смотрите исторически
    /// фильмы на
    static let title = Strings.tr("Localizable", "title", fallback: "Смотрите исторически\nфильмы на")
    /// token
    static let token = Strings.tr("Localizable", "token", fallback: "token")
    /// tv-series
    static let type = Strings.tr("Localizable", "type", fallback: "tv-series")
    /// Verdana
    static let verdana = Strings.tr("Localizable", "verdana", fallback: "Verdana")
    /// Verdana-Bold
    static let verdanaBold = Strings.tr("Localizable", "verdanaBold", fallback: "Verdana-Bold")
    /// X-API-KEY
    static let xapikey = Strings.tr("Localizable", "XAPIKEY", fallback: "X-API-KEY")
}

// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
        let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle: Bundle = {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        return Bundle(for: BundleToken.self)
        #endif
    }()
}

// swiftlint:enable convenience_type
