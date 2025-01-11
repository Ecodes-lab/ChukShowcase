//
//  String+Ext.swift
//  ChukShowcase
//
//  Created by Eco Dev S-SSD  on 11/01/2025.
//

import Foundation

extension String {

    func extractText() -> (Range<String.Index>, String)? {
        let pattern = "(CK)([a-z0-9]{32})" // The CK could be anything you want, your initials, your company name, or your product name
        
        guard let range = self.range(of: pattern, options: .regularExpression, range: nil, locale: nil) else {
            // No text found.
            return nil
        }

        var text = "" // Note: The varibale text could anything you want (eg. code, product etc)
        let substring = String(self[range])
        let nsrange = NSRange(substring.startIndex..., in: substring)
        do {
            // Extract the characters from the substring.
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            if let match = regex.firstMatch(in: substring, options: [], range: nsrange) {
                for rangeInd in 1 ..< match.numberOfRanges {
                    let range = match.range(at: rangeInd)
                    let matchString = (substring as NSString).substring(with: range)
                    text += matchString as String
                }
            }
        } catch {
            print("Error \(error) when creating pattern")
        }
        
        guard text.count == 34 else {
            return nil
        }
        
        text = String(text.dropFirst(3))
        
        // Substitute commonly misrecognized characters, for example: 'S' -> '5' or 'l' -> '1'
        var result = ""
        let allowedChars = "abcdefghijklmnopqrstuvwxyz0123456789"
        for var char in text {
            char = char.getSimilarCharacterIfNotIn(allowedChars: allowedChars)
            guard allowedChars.contains(char) else {
                return nil
            }
            result.append(char)
        }
        return (range, result)
    }
    
    // Extracts the first US-style phone number found in the string, returning
    // the range of the number and the number itself as a tuple.
    // Returns nil if no number is found.
    func extractPhoneNumber() -> (Range<String.Index>, String)? {
        // Do a first pass to find any substring that could be a US phone
        // number. This will match the following common patterns and more:
        // xxx-xxx-xxxx
        // xxx xxx xxxx
        // (xxx) xxx-xxxx
        // (xxx)xxx-xxxx
        // xxx.xxx.xxxx
        // xxx xxx-xxxx
        // xxx/xxx.xxxx
        // +1-xxx-xxx-xxxx
        // Note that this doesn't only look for digits since some digits look
        // very similar to letters. This is handled later.
        let pattern = #"""
        (?x)                    # Verbose regex, allows comments
        (?:\+1-?)?                # Potential international prefix, may have -
        [(]?                    # Potential opening (
        \b(\w{3})                # Capture xxx
        [)]?                    # Potential closing )
        [\ -./]?                # Potential separator
        (\w{3})                    # Capture xxx
        [\ -./]?                # Potential separator
        (\w{4})\b                # Capture xxxx
        """#
        
        guard let range = self.range(of: pattern, options: .regularExpression, range: nil, locale: nil) else {
            // No phone number found.
            return nil
        }
        
        // Potential number found. Strip out punctuation, whitespace and country
        // prefix.
        var phoneNumberDigits = ""
        let substring = String(self[range])
        let nsrange = NSRange(substring.startIndex..., in: substring)
        do {
            // Extract the characters from the substring.
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            if let match = regex.firstMatch(in: substring, options: [], range: nsrange) {
                for rangeInd in 1 ..< match.numberOfRanges {
                    let range = match.range(at: rangeInd)
                    let matchString = (substring as NSString).substring(with: range)
                    phoneNumberDigits += matchString as String
                }
            }
        } catch {
            print("Error \(error) when creating pattern")
        }
        
        // Must be exactly 10 digits.
//        print(phoneNumberDigits.count)
        guard phoneNumberDigits.count == 10 else {
            return nil
        }
        
//        for strString in phoneNumberDigits {
//            if(strString.count > 3){
//                let startIndex = strString.index(strString.startIndex, offsetBy: 3)
//                let str = String(strString[..<startIndex])
//                print(str)
//                if(str.lowercased() == "zar"){
//                    let str = strString.dropFirst(3)
//                    print(str)
//                    return
//                }
//            }
//        }
        
        let str = phoneNumberDigits.dropFirst(3)
                
        // Substitute commonly misrecognized characters, for example: 'S' -> '5' or 'l' -> '1'
        var result = ""
        let allowedChars = "abcdefghijklmnopqrstuvwxyz0123456789"
        for var char in str {
            char = char.getSimilarCharacterIfNotIn(allowedChars: allowedChars)
            guard allowedChars.contains(char) else {
                return nil
            }
            result.append(char)
        }
        return (range, result)
    }
}
