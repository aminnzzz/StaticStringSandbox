//
//  main.swift
//  StaticStringSandbox
//
//  Created by amin nazemzadeh on 11/25/24.
//

import Foundation

print("Hello, World!")

let name = "Amin"

assert(name.count >= 10, "Name should be at least 10 characters")

// look at the terminal, anything interesting?
// #file and #line are macros, but why are they static strings instead of regular strings?

// creating them never triggers assertions
// extremely close to bare metal... fast

// most importantly, these strings are always known at compile time, content either correct or not... what we type

if let url = URL(string: "https://apple.com") {
    print("url correct")
}

extension URL {
    init(staticString: StaticString) {
        let string = String(describing: staticString)

        if let url = URL(string: string) {
            self = url
        } else {
            fatalError("Unable to create URL from static string: \(staticString)")
        }
    }
}
// removed the optionality
let url2 = URL(staticString: "https://apple.com")

let domain = "apple.com"
let possibleURL = URL(staticString: "https://\(domain)") // no longer a static string, string interpolation is risky, no compile time safety

extension AttributedString {
    init(staticString: StaticString) {
        let string = String(describing: staticString)
        do {
            self = try AttributedString(markdown: string)
        } catch {
            fatalError("Failed to create AttributedString from \(string) \(error.localizedDescription)")
        }
    }
}

let myString = AttributedString(staticString: "**Hello!**")
