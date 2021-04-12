// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal static let mainClay = ColorAsset(name: "mainClay")
  internal static let mainLavender = ColorAsset(name: "mainLavender")
  internal static let mainNightBlue = ColorAsset(name: "mainNightBlue")
  internal static let mainSage = ColorAsset(name: "mainSage")
  internal static let mainSand = ColorAsset(name: "mainSand")
  internal static let secondaryBlue = ColorAsset(name: "secondaryBlue")
  internal static let secondaryGreen = ColorAsset(name: "secondaryGreen")
  internal static let secondaryOrange = ColorAsset(name: "secondaryOrange")
  internal static let secondaryRed = ColorAsset(name: "secondaryRed")
  internal static let systemDark = ColorAsset(name: "systemDark")
  internal static let systemDarkGray = ColorAsset(name: "systemDarkGray")
  internal static let systemLight = ColorAsset(name: "systemLight")
  internal static let systemLightGray = ColorAsset(name: "systemLightGray")
  internal static let systemMidGray = ColorAsset(name: "systemMidGray")
  internal static let tabBarUnselected = ColorAsset(name: "tabBarUnselected")
  internal static let mainBlueLabel = ColorAsset(name: "mainBlueLabel")
  internal static let mainDarkBlueLabel = ColorAsset(name: "mainDarkBlueLabel")
  internal static let calendar = ImageAsset(name: "Calendar")
  internal static let chevronRight = ImageAsset(name: "ChevronRight")
  internal static let message = ImageAsset(name: "Message")
  internal static let calendarBig = ImageAsset(name: "calendarBig")
  internal static let chatsTab = ImageAsset(name: "chatsTab")
  internal static let checkInTab = ImageAsset(name: "checkInTab")
  internal static let checkbox = ImageAsset(name: "checkbox")
  internal static let checkin = ImageAsset(name: "checkin")
  internal static let eventNotificationPlus = ImageAsset(name: "eventNotificationPlus")
  internal static let info = ImageAsset(name: "info")
  internal static let messageFailed = ImageAsset(name: "messageFailed")
  internal static let myColleagues = ImageAsset(name: "myColleagues")
  internal static let notification = ImageAsset(name: "notification")
  internal static let plusAttachment = ImageAsset(name: "plusAttachment")
  internal static let profileOriginal = ImageAsset(name: "profileOriginal")
  internal static let profileTemplate = ImageAsset(name: "profileTemplate")
  internal static let sendMessage = ImageAsset(name: "sendMessage")
  internal static let threePersonOriginal = ImageAsset(name: "threePersonOriginal")
  internal static let threePersonTemplate = ImageAsset(name: "threePersonTemplate")
  internal static let twoPersonOriginal = ImageAsset(name: "twoPersonOriginal")
  internal static let twoPersonTemplate = ImageAsset(name: "twoPersonTemplate")
  internal static let more = ImageAsset(name: "more")
  internal static let close = ImageAsset(name: "close")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
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

