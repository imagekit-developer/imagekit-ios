//
//  MimeDetector.swift
//  ImageKit
//
//  Created by Abhinav Dhiman on 29/08/20.
//

import Foundation

public struct MimeDetector {
  /// File data
  let data: Data

  ///  A static method to get the `MimeType` that matches the given file data
  ///
  ///  - returns: Optional<MimeType>
  static public func mimeType(data: Data) -> MimeType? {
    return mimeType(mimeDetector: MimeDetector(data: data))
  }

  ///  A static method to get the `MimeType` that matches the given bytes
  ///
  ///  - returns: Optional<MimeType>
  static public func mimeType(bytes: [UInt8]) -> MimeType? {
    return mimeType(mimeDetector: MimeDetector(bytes: bytes))
  }

  ///  Get the `MimeType` that matches the given `MimeDetector` instance
  ///
  ///  - returns: Optional<MimeType>
  static public func mimeType(mimeDetector: MimeDetector) -> MimeType? {
    let bytes = mimeDetector.readBytes(count: min(mimeDetector.data.count, 262))

    for mime in MimeType.all {
      if mime.matches(bytes: bytes, mimeDetector: mimeDetector) {
        return mime
      }
    }

    return nil
  }

  public init(data: Data) {
    self.data = data
  }

  public init(bytes: [UInt8]) {
    self.init(data: Data(bytes))
  }

  ///  Read bytes from file data
  ///
  ///  - parameter count: Number of bytes to be read
  ///
  ///  - returns: Bytes represented with `[UInt8]`
  public func readBytes(count: Int) -> [UInt8] {
    var bytes = [UInt8](repeating: 0, count: count)

    data.copyBytes(to: &bytes, count: count)

    return bytes
  }
}
