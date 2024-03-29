//
//  AudioStatus.swift
//  Capture
//
//  Created by Consultant on 9/24/22.
//

import Foundation

enum AudioStatus: Int, CustomStringConvertible{
    case stopped,
         playing,
         recording
    
    var audioName: String{
        let audioNames = ["Audio:Stopped", "Audio:Playing", "Audio:Recording"]
        return audioNames[rawValue]
    }
    
    var description: String{
        return audioName
    }
}
