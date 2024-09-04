// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum WithYouAsset {
  public static let accentColor = WithYouColors(name: "AccentColor")
  public static let cloud = WithYouImages(name: "Cloud")
  public static let postbook = WithYouImages(name: "Postbook")
  public static let rewind = WithYouImages(name: "Rewind")
  public static let calendarIcon = WithYouImages(name: "CalendarIcon")
  public static let calendarIconDark = WithYouImages(name: "CalendarIconDark")
  public static let backgroundColor = WithYouColors(name: "BackgroundColor")
  public static let gray2 = WithYouColors(name: "Gray2")
  public static let mainColor = WithYouColors(name: "MainColor")
  public static let mainColorDark = WithYouColors(name: "MainColorDark")
  public static let pointColor = WithYouColors(name: "PointColor")
  public static let subColor = WithYouColors(name: "SubColor")
  public static let underlineColor = WithYouColors(name: "UnderlineColor")
  public static let downMark = WithYouImages(name: "DownMark")
  public static let angry = WithYouImages(name: "angry")
  public static let heart = WithYouImages(name: "heart")
  public static let lucky = WithYouImages(name: "lucky")
  public static let sad = WithYouImages(name: "sad")
  public static let soso = WithYouImages(name: "soso")
  public static let sunny = WithYouImages(name: "sunny")
  public static let surprised = WithYouImages(name: "surprised")
  public static let touched = WithYouImages(name: "touched")
  public static let homeIcon = WithYouImages(name: "HomeIcon")
  public static let iconCheckOff = WithYouImages(name: "Icon-Check-off")
  public static let iconCheckOn = WithYouImages(name: "Icon-Check-on")
  public static let image = WithYouImages(name: "Image")
  public static let inIcon = WithYouImages(name: "InIcon")
  public static let launchImage = WithYouImages(name: "LaunchImage")
  public static let logModel0 = WithYouImages(name: "LogModel0")
  public static let logModel1 = WithYouImages(name: "LogModel1")
  public static let logModel2 = WithYouImages(name: "LogModel2")
  public static let logModel3 = WithYouImages(name: "LogModel3")
  public static let logo = WithYouImages(name: "Logo")
  public static let logoColor = WithYouColors(name: "LogoColor")
  public static let mascout = WithYouImages(name: "Mascout")
  public static let messageIcon = WithYouImages(name: "MessageIcon")
  public static let myIcon = WithYouImages(name: "MyIcon")
  public static let appleLogin = WithYouImages(name: "AppleLogin")
  public static let googleLogin = WithYouImages(name: "GoogleLogin")
  public static let kakaoLogin = WithYouImages(name: "KakaoLogin")
  public static let mainLogo = WithYouImages(name: "MainLogo")
  public static let mockUp = WithYouImages(name: "MockUp")
  public static let mockUp1 = WithYouImages(name: "MockUp1")
  public static let mockUp2 = WithYouImages(name: "MockUp2")
  public static let mockUp3 = WithYouImages(name: "MockUp3")
  public static let mockUpBefore = WithYouImages(name: "MockUpBefore")
  public static let out = WithYouImages(name: "Out")
  public static let packingIcon = WithYouImages(name: "PackingIcon")
  public static let searchIcon = WithYouImages(name: "SearchIcon")
  public static let sideMenu = WithYouImages(name: "SideMenu")
  public static let sortIcon = WithYouImages(name: "SortIcon")
  public static let post1 = WithYouImages(name: "post1")
  public static let post2 = WithYouImages(name: "post2")
  public static let post3 = WithYouImages(name: "post3")
  public static let post4 = WithYouImages(name: "post4")
  public static let post5 = WithYouImages(name: "post5")
  public static let travelLogIcon = WithYouImages(name: "TravelLogIcon")
  public static let checkbox = WithYouImages(name: "checkbox")
  public static let testProfile = WithYouImages(name: "testProfile")
  public static let xmark = WithYouImages(name: "xmark")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class WithYouColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if canImport(SwiftUI)
  private var _swiftUIColor: Any? = nil
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public private(set) var swiftUIColor: SwiftUI.Color {
    get {
      if self._swiftUIColor == nil {
        self._swiftUIColor = SwiftUI.Color(asset: self)
      }

      return self._swiftUIColor as! SwiftUI.Color
    }
    set {
      self._swiftUIColor = newValue
    }
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension WithYouColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: WithYouColors) {
    let bundle = WithYouResources.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Color {
  init(asset: WithYouColors) {
    let bundle = WithYouResources.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct WithYouImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = WithYouResources.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

public extension WithYouImages.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the WithYouImages.image property")
  convenience init?(asset: WithYouImages) {
    #if os(iOS) || os(tvOS)
    let bundle = WithYouResources.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Image {
  init(asset: WithYouImages) {
    let bundle = WithYouResources.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: WithYouImages, label: Text) {
    let bundle = WithYouResources.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: WithYouImages) {
    let bundle = WithYouResources.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
