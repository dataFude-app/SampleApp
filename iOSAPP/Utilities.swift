import Foundation
import SwiftUI
import os

// In case muscle memory leads you to using `print` more often than not,
// you can just route that output to your logs and use it to drive dataTile too.
func print(_ text: some CustomStringConvertible) {
    #if DEBUG
    os_log("\(text.description, privacy: .public)")
    #endif
}

// Scroll offset modifier.
struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

// A cross-platform background color value.
extension Color {
#if os(macOS)
    static var backgroundColor: Color {
        return Color(nsColor: .textBackgroundColor)
    }
#else
    static var backgroundColor: Color {
        return Color(uiColor: .systemBackground)
    }
#endif
}

// Produces the country flag from a country code
func countryFlag(_ countryCode: String) -> String {
    String(String.UnicodeScalarView(countryCode.unicodeScalars.compactMap {
        UnicodeScalar(127397 + $0.value)
    }))
}
