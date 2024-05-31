// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  /// Актеры и съемочная группа 
  internal static let actorsText = Strings.tr("Localizable", "actorsText", fallback: "Актеры и съемочная группа ")
  /// transform.translation.x
  internal static let animation = Strings.tr("Localizable", "animation", fallback: "transform.translation.x")
  /// api.kinopoisk.dev
  internal static let apiKinopoiskDev = Strings.tr("Localizable", "ApiKinopoiskDev", fallback: "api.kinopoisk.dev")
  /// 92JSXDT-SVE4DKZ-KWA35X9-K3H52VA
  internal static let apiToken = Strings.tr("Localizable", "apiToken", fallback: "92JSXDT-SVE4DKZ-KWA35X9-K3H52VA")
  /// arrow
  internal static let arrow = Strings.tr("Localizable", "arrow", fallback: "arrow")
  /// arrow2
  internal static let arrow2 = Strings.tr("Localizable", "arrow2", fallback: "arrow2")
  /// backArrow
  internal static let backArrow = Strings.tr("Localizable", "backArrow", fallback: "backArrow")
  ///  CINEMA STAR
  internal static let cinemaStar = Strings.tr("Localizable", "cinemaStar", fallback: " CINEMA STAR")
  /// Localizable.strings
  ///   CinemaStar
  /// 
  ///   Created by Vermut xxx on 31.05.2024.
  internal static let containerName = Strings.tr("Localizable", "containerName", fallback: "CacheDataModel")
  /// MovieCardsCoreDataStorage
  internal static let entityNameMovieCard = Strings.tr("Localizable", "entityNameMovieCard", fallback: "MovieCardsCoreDataStorage")
  /// MovieDetailsCoreDataStorage
  internal static let entityNameMovieDetails = Strings.tr("Localizable", "entityNameMovieDetails", fallback: "MovieDetailsCoreDataStorage")
  /// Failure data
  internal static let failureText = Strings.tr("Localizable", "failureText", fallback: "Failure data")
  /// favourite
  internal static let fav = Strings.tr("Localizable", "fav", fallback: "favourite")
  /// favourites2
  internal static let fav2 = Strings.tr("Localizable", "fav2", fallback: "favourites2")
  /// Фильм
  internal static let film = Strings.tr("Localizable", "film", fallback: "Фильм")
  /// Функционал в разработке:(
  internal static let funcInDevelop = Strings.tr("Localizable", "funcInDevelop", fallback: "Функционал в разработке:(")
  /// история
  internal static let history = Strings.tr("Localizable", "history", fallback: "история")
  /// https
  internal static let https = Strings.tr("Localizable", "https", fallback: "https")
  /// Язык
  internal static let lang = Strings.tr("Localizable", "lang", fallback: "Язык")
  /// Смотрите также
  internal static let lookMore = Strings.tr("Localizable", "lookMore", fallback: "Смотрите также")
  /// Смотреть
  internal static let lookText = Strings.tr("Localizable", "lookText", fallback: "Смотреть")
  /// /v1.4/movie/
  internal static let movie = Strings.tr("Localizable", "movie", fallback: "/v1.4/movie/")
  /// /v1.4/movie/search
  internal static let movieSearch = Strings.tr("Localizable", "movieSearch", fallback: "/v1.4/movie/search")
  /// Упс!
  internal static let ops = Strings.tr("Localizable", "ops", fallback: "Упс!")
  /// query
  internal static let query = Strings.tr("Localizable", "query", fallback: "query")
  /// Сериал
  internal static let serial = Strings.tr("Localizable", "serial", fallback: "Сериал")
  /// shimmerAnimation
  internal static let shimmerAnimation = Strings.tr("Localizable", "shimmerAnimation", fallback: "shimmerAnimation")
  /// ⭐️
  internal static let star = Strings.tr("Localizable", "star", fallback: "⭐️")
  /// Смотрите исторически
  /// фильмы на
  internal static let title = Strings.tr("Localizable", "title", fallback: "Смотрите исторически\nфильмы на")
  /// token
  internal static let token = Strings.tr("Localizable", "token", fallback: "token")
  /// tv-series
  internal static let type = Strings.tr("Localizable", "type", fallback: "tv-series")
  /// Verdana
  internal static let verdana = Strings.tr("Localizable", "verdana", fallback: "Verdana")
  /// Verdana-Bold
  internal static let verdanaBold = Strings.tr("Localizable", "verdanaBold", fallback: "Verdana-Bold")
  /// X-API-KEY
  internal static let xapikey = Strings.tr("Localizable", "XAPIKEY", fallback: "X-API-KEY")
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
