//
//  MockData.swift
//  BBQuotes
//
//  Created by Yuna Chou on 2024/10/1.
//

import Foundation

extension Quote {
    static let mock = Quote(
        quote: "I am the one who knocks!",
        character: "Walter White"
    )
}

extension Character {
    static let mock = Character(
        name: "Walter White",
        birthday: "09-07-1958",
        occupations: ["High School Chemistry Teacher", "Meth King Pin"],
        images: [URL(string: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg")!],
        aliases: ["Heisenberg"],
        status: "Dead",
        portrayedBy: "Bryan Cranston",
        death: Death.mock
    )
}

extension Death {
    static let mock = Death(
        character: "Walter White",
        image: URL(string: "https://static.wikia.nocookie.net/breakingbad/images/9/9e/Walt%27s_Death.png/revision/latest?cb=20221121191611")!,
        details: "Accidentally hit by a ricocheting bullet from his own M60 machine gun.",
        lastWords: "Well, erm... goodbye, Lydia."
    )
}

extension ViewModel {
    static var preview: ViewModel {
        let viewModel = ViewModel()
        viewModel.quote = .mock
        viewModel.character = .mock
        viewModel.fetchStatus = .success
        return viewModel
    }
}
