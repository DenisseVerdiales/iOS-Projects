//
//  Config.swift
//  Capture
//
//  Created by Consultant on 9/18/22.
//

import Foundation

func getDocumentDirector() -> URL{
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func getAudioFileName() -> String{
   //return "audioExample.m4a"
    return "recording.caf"
}
