import UIKit

// Implement a function with this signature:
// 'indexOf(word: String, morse: String) -> Int?'.
//
// 'morse' is a string of '.' and '-'.
// 'word' is a string of characters [a-zA-Z]
// 'indexOf' will return an optional with the index of the start of the word
//    if the word is represented in morse code.
//
// There are no spaces, numbers, word breaks, or letter breaks indicated in the morse code string.
//
// The following dictionary represents the ./- encoding of the letters of the alphabet
//
// let encoding = [ "A":".-", "B":"-...",
//                     "C":"-.-.", "D":"-..", "E":".",
//                     "F":"..-.", "G":"--.", "H":"....",
//                     "I":"..", "J":".---", "K":"-.-",
//                     "L":".-..", "M":"--", "N":"-.",
//                     "O":"---", "P":".--.", "Q":"--.-",
//                     "R":".-.", "S":"...", "T":"-",
//                     "U":"..-", "V":"...-", "W":".--",
//                     "X":"-..-", "Y":"-.--", "Z":"--.."]
//
// indexOf(word: "HELLO", morse: "......-...-..---") // will return 0.
// indexOf(word: "WORLD", morse: ".-") // will return nil.
//
// An optimized solution isn't necessary, as the strings will always be short strings.
// A clean solution is desired. (Easy to read, clear intent.)


let encoding: [Character: String] = [ "A":".-", "B":"-...",
                 "C":"-.-.", "D":"-..", "E":".",
                 "F":"..-.", "G":"--.", "H":"....",
                 "I":"..", "J":".---", "K":"-.-",
                 "L":".-..", "M":"--", "N":"-.",
                 "O":"---", "P":".--.", "Q":"--.-",
                 "R":".-.", "S":"...", "T":"-",
                 "U":"..-", "V":"...-", "W":".--",
                 "X":"-..-", "Y":"-.--", "Z":"--.."]

func indexOf(word: String, morse: String) -> Int? {
    // Convert word to morse code
    let wordMorse: [Character] = word.compactMap { char in
        return encoding[char]
    }.flatMap{ $0 }
    
//    print(wordMorse)
    guard wordMorse.count <= morse.count else { return nil }
    var startIndex = 0
    var endIndex = wordMorse.count - 1
    
    let morseCharArr = Array(morse)
    
    while endIndex < morse.count {
        let subRange = Array(morseCharArr[startIndex...endIndex])
        if subRange == wordMorse {
            return startIndex
        }
        
        startIndex += 1
        endIndex += 1
    }
    
    return nil
}


//print(indexOf(word: "HELLO", morse: "......-...-..---"))
//print(indexOf(word: "WORLD", morse: ".-"))
print(indexOf(word: "SO", morse: "......---..."))
