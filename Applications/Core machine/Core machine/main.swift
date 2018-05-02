//
//  main.swift
//  Core machine
//
//  Created by UDLAP on 2/14/18.
//  Copyright © 2018 151211. All rights reserved.
//

import Foundation

func getLanguage(_ text:String)->String{
    let tagger:NSLinguisticTagger
    let language:String
    
    tagger = NSLinguisticTagger(tagSchemes: [NSLinguisticTagScheme.language], options:0)
    tagger.string = text
    language = tagger.dominantLanguage!
    return language
}

func getNounType(_ text:String)->String{
    var tagger : NSLinguisticTagger
    var range:NSRange
    var options:NSLinguisticTagger.Options
    var tags:Array<NSLinguisticTag>
    var nameType:String
    nameType = ""
    
    tagger = NSLinguisticTagger(tagSchemes: [NSLinguisticTagScheme.nameType], options:0)
    tagger.string = text
    range = NSRange(location:0, length: text.utf16.count)
    options = [.omitPunctuation, .omitWhitespace, .joinNames]
    tags = [.personalName, .placeName, .organizationName]
    
    tagger.enumerateTags(in: range, unit: .word, scheme: .nameType, options: options){
        tag, tokenRange, stop
        in
        if let aTag = tag, tags.contains(aTag){
            let name = (text as NSString).substring(with: tokenRange)
            nameType = "\(name): \(aTag.rawValue)"
        }
    }
    return nameType
}

func getTokens(_ text:String)-> Array<String>{
    var tagger:NSLinguisticTagger
    var range:NSRange
    var options:NSLinguisticTagger.Options
    var tokens:Array<String>
    
    tokens=[]
    tagger = NSLinguisticTagger(tagSchemes:[.tokenType], options:0)
    tagger.string = text
    range=NSRange(location:0, length:text.utf16.count)
    options = [.omitPunctuation, .omitWhitespace]
    tagger.enumerateTags(in: range, unit: .word, scheme: .tokenType, options: options){
        _, tokenRange, stop
        in let word = (text as NSString).substring(with: tokenRange)
        tokens.append(word)
    }
    return tokens
}

func getPartsOfSpeech(_ text: String)-> [String:String]{
    var tagger:NSLinguisticTagger
    var range:NSRange
    var options:NSLinguisticTagger.Options
    var partsOfSpeech:[String:String]
    
    partsOfSpeech=[:]
    tagger = NSLinguisticTagger(tagSchemes:[NSLinguisticTagScheme.lexicalClass], options:0)
    tagger.string=text
    range=NSRange(location:0, length:text.utf16.count)
    options = [.omitPunctuation, .omitWhitespace]
    tagger.enumerateTags(in: range, unit: .word, scheme: .lexicalClass, options: options){
        tag, tokenRange, stop
        in
        if let theTag = tag{
            let word = (text as NSString).substring(with: tokenRange)
            partsOfSpeech[word] = theTag.rawValue
        }
    }
    return partsOfSpeech
}

var idioma : String
var palabra : String
var palabras : Array<String>

idioma = getLanguage("Hallo, wie geht's?")
print(idioma)

print(getNounType("Juan Pablo"))
print(getTokens("Hola me llamo Raúl, estudio ingenierìa en sistemas computacionales en la universidad de las amèricas Puebla"))
print(getPartsOfSpeech("Hola me llamo Raúl, estudio ingenierìa en sistemas computacionales en la universidad de las amèricas Puebla"))
print(getPartsOfSpeech("If I were you, I would like to buy a car"))
