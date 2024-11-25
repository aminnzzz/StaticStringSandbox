//
//  main.swift
//  StaticStringSandbox
//
//  Created by amin nazemzadeh on 11/25/24.
//

import Foundation

/*
difference with string: need to hand type characters
 no string interpolation or loading through codable
 known string at compile time
 */

print("Hello, Static String!")

// swift/stdlib/public/core/assert.swift

let name = "Amin"

assert(name.count >= 10, "Name should be at least 10 characters")

// look at the terminal, anything interesting?
// #file and #line are macros, but why are they static strings instead of regular strings?

/*
 very interesting case of infinite recursion

 if assert, fatalError, preCondition used String, which could call assert internally -> infinite recurstion
 */

// creating them never triggers assertions
// extremely close to bare metal... faster

// most importantly, these strings are always known at compile time, content either correct or not... what we type matters
// if you type the URL wrong for example for tests, mocks and etc, recovering might be pointless, the test needs to just fail instead of using do catch blocks and etc

/*
cannot mutate or change, holds string literals,
 swift stores it more efficiently knowing that it won't change
 it can be initialized with an address pointer and length
 not alloced or dealloced, no reference counting needed
 */

// do not know the contents of string at compile time, can fail at run time
if let url = URL(string: "https://apple.com") {
    print("string was correct") // not checking the validity of the website itself
}
// static string knows it's content at compile time
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
// removed the optionality, we handtyped the URL, we know it's correct, mostly copied from Contentful!
let url2 = URL(staticString: "https://apple.com")
// imagine domain was passed by user, no longer hand typed by us, so we fail the init because there is a risk
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
