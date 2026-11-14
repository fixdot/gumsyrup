//
//  main.swift
//  GumSyrup
//
//  Created by fix on 2026/10/11.
//  Assisted by ChatGPT.
//  Copyright (c) 2026 fix
//  SPDX-License-Identifier: MIT
//

import Foundation
import Carbon

let version =
	Bundle.main.object(
		forInfoDictionaryKey: "CFBundleShortVersionString"
	) as? String ?? "unknown"

let arguments = Array(CommandLine.arguments.dropFirst())

switch arguments {
case ["-V"], ["--version"]:
	print("GumSyrup \(version)")
	exit(0)

case ["-h"], ["--help"]:
	print("""
	GumSyrup

	Usage:
	  gumsyrup
	  gumsyrup -h, --help
	  gumsyrup -V, --version

	Description:
	  Switches the input source to a supported English input source
	  before the next shell prompt.

	Supported English input sources:
	  U.S.
	  ABC
	  ABC Extended
	""")
	exit(0)

case []:
	break

default:
	exit(0)
}

// Supported English input sources.
// GumSyrup only switches when exactly one of these is enabled.
let supportedEnglishInputSourceIDs: Set<String> = [
	"com.apple.keylayout.US",
	"com.apple.keylayout.ABC",
	"com.apple.keylayout.USExtended",
]

// Returns the input source identifier.
func inputSourceID(_ source: TISInputSource) -> String? {
	guard
		let value = TISGetInputSourceProperty(
			source,
			kTISPropertyInputSourceID
		)
	else {
		return nil
	}

	return Unmanaged<CFString>
		.fromOpaque(value)
		.takeUnretainedValue() as String
}

// Get the currently selected input source.
guard
	let currentSource = TISCopyCurrentKeyboardInputSource()?
		.takeRetainedValue(),
	let currentID = inputSourceID(currentSource)
else {
	exit(0)
}

// Already using a supported English input source.
if supportedEnglishInputSourceIDs.contains(currentID) {
	exit(0)
}

// Get all enabled input sources.
guard
	let sourceList = TISCreateInputSourceList(nil, false)?
		.takeRetainedValue() as? [TISInputSource]
else {
	exit(0)
}

// Find supported English input sources currently enabled.
let enabledEnglishSources = sourceList.filter { source in
	guard let sourceID = inputSourceID(source) else {
		return false
	}

	return supportedEnglishInputSourceIDs.contains(sourceID)
}

// Switch only when the destination is unambiguous.
guard enabledEnglishSources.count == 1 else {
	exit(0)
}

// GumSyrup is intentionally silent even if the switch fails.
_ = TISSelectInputSource(enabledEnglishSources[0])
