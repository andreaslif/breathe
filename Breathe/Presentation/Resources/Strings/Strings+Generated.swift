// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Copy {
  internal enum ConfigView {
    /// Exercise will repeat
    internal static let exerciseText = Copy.tr("Localizable", "ConfigView.exerciseText", fallback: "Exercise will repeat")
    /// indefinitely
    internal static let indefinitely = Copy.tr("Localizable", "ConfigView.indefinitely", fallback: "indefinitely")
    /// times
    internal static let times = Copy.tr("Localizable", "ConfigView.times", fallback: "times")
  }
  internal enum HomeView {
    /// Exhale
    internal static let exhaling = Copy.tr("Localizable", "HomeView.exhaling", fallback: "Exhale")
    /// Inhale
    internal static let inhaling = Copy.tr("Localizable", "HomeView.inhaling", fallback: "Inhale")
    /// Start
    internal static let start = Copy.tr("Localizable", "HomeView.start", fallback: "Start")
    /// Stop
    internal static let stop = Copy.tr("Localizable", "HomeView.stop", fallback: "Stop")
    /// Take a break
    internal static let stopped = Copy.tr("Localizable", "HomeView.stopped", fallback: "Take a break")
  }
  internal enum RepeatMode {
    /// Counting
    internal static let finite = Copy.tr("Localizable", "RepeatMode.finite", fallback: "Counting")
    /// Continuous
    internal static let infinite = Copy.tr("Localizable", "RepeatMode.infinite", fallback: "Continuous")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Copy {
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
