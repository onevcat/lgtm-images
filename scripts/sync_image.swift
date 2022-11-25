#!/usr/bin/env swift

import Foundation

let fileManager = FileManager.default
let imagesPath: String = fileManager.currentDirectoryPath.appending("/images")

var imageNames: [String] = []

let enumerator = fileManager.enumerator(atPath: imagesPath)
while let filename = enumerator?.nextObject() as? String {
  imageNames.append(filename)
}

var text = "## Images\n\n"

let prefix = "https://raw.githubusercontent.com/onevcat/lgtm-images/master/images/"
let divider = "---"

let content = imageNames
  .filter {
    $0 != ".DS_Store"
  }
  .map {
    [
      divider,
      "<img src=\"\(prefix)\($0)\" width=\"200\">\n",
      "`![](\(prefix)\($0))`\n"
    ].joined(separator: "\n")
  }.joined(separator: "\n")

text.append(content)

let outputPath = fileManager.currentDirectoryPath.appending("/README.md")
try? text.write(toFile: outputPath, atomically: true, encoding: .utf8)
