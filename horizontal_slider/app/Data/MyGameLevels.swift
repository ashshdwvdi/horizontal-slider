//
//  MyGameLevels.swift
//  horizontal_slider
//
//  Created by Ashish Dwivedi on 30/01/22.
//

import Foundation

extension Game {
    static let me = Game(levels: [
        .about, .skills, .oldJob, .currentJob, .toBeContinued
    ])
}

extension LevelInfo {
    static let about = LevelInfo(
        title: "About",
        heading: "Software Engineer - iOS",
        contents: [
            "🎢 I am a native iOS developer very zealous in creating and improving iOS app.",
            "📪 dwivediashish.work@gmail.com",
            "🌏 Gujarat, India"
        ]
    )
    static let currentJob =  LevelInfo(
        title: "Currently working",
        heading: "Toppr Technologies",
        contents: [
            "Managed Toppr Basic, Toppr Plus, BFS - Free and Paid app.",
            "Worked on improving the code quality and implemented a scrolling UI game to be used in apps.",
            "Worked on implementing classroom video conferencing module using Twilio to support video/screen sharing support for 1:4 participants.",
            "Handled web socket integration and Webview interaction for Quiz implementation.",
            "Helped team with code quality control using CocoaPods module and code reviews.",
            "Improved App security by implementing SSL pinning."
        ]
    )
    static let oldJob = LevelInfo(
        title: "Old Job",
        heading: "Poshmark",
        contents: [
            "Worked on migrating entire Home Feed and Shop Feed tab to Swift MVVM architecture.",
            "Integrated Ad tracking managers Apps Flyer and GTM.",
            "Migrated Facebook development kit to remove Auth Token stored on client side to improve security.",
            "Improved performance of Listing creation when user has over 80K images on their phone and iCloud using caching.",
            "Implemented Recent search item feature to be synced up with multiple logged in devices.",
            "Migrated bulks of legacy code to Swift writing Unit Tests."
        ]
    )
    static let openSource = LevelInfo(
        title: "Personal Projects",
        heading: "On Github",
        contents: [
            "Try not to laugh challenge.",
            "Chat bot for cricket scores.",
            "Health kit daily step counter.",
            "Parallax animation | Collection view | UIKit.",
            "Hackathon organiser.",
        ]
    )
    static let skills = LevelInfo(
        title: "Skills",
        heading: "Coding",
        contents: [
            "Objective C",
            "Swift",
            "Python",
            "Javascript",
            "Java and JSP",
            "Git"
        ]
    )
    static let toBeContinued = LevelInfo(
        title: "To Be Continued",
        heading: "That's all folks",
        contents: [
            "Bye",
            "Bye",
            "And",
            "Take",
            "Care"
        ]
    )
}
