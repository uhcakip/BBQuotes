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
        images: [
            URL(string: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg")!,
            URL(string: "https://static.wikia.nocookie.net/breakingbad/images/e/e7/BB-S5B-Walt-590.jpg/revision/latest?cb=20130928055404")!,
            URL(string: "https://static.wikia.nocookie.net/breakingbad/images/4/4a/Season_2_promo_pic_6.jpg/revision/latest?cb=20120617212256")!,
            URL(string: "https://static.wikia.nocookie.net/breakingbad/images/b/b4/Walter_2008.png/revision/latest?cb=20200704164147")!,
            URL(string: "https://static.wikia.nocookie.net/breakingbad/images/e/ea/Season_4_-_Heisenberg.jpg/revision/latest?cb=20110817002354")!,
            URL(string: "https://static.wikia.nocookie.net/breakingbad/images/d/d1/Season_4_-_Walt.jpg/revision/latest?cb=20220805224819")!,
            URL(string: "https://static.wikia.nocookie.net/breakingbad/images/5/57/Walter_White_5A_Promotional_Image.jpg/revision/latest?cb=20221207180019")!,
            URL(string: "https://static.wikia.nocookie.net/breakingbad/images/c/c0/WaltS5.jpg/revision/latest?cb=20120620012205")!,
        ],
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

extension Episode {
    static let mock = Episode(
        episode: 101,
        title: "Pilot",
        image: URL(string: "https://static.wikia.nocookie.net/breakingbad/images/b/b1/BB_101_S.jpg/revision/latest?cb=20170418193804")!,
        synopsis: "Unassuming high school chemistry teacher Walter White discovers he has lung cancer. Desperate to secure his family's financial future and finally free from the fear that had always inhibited him, Walt teams up with a former student to turn a used RV into a mobile drug lab.",
        writtenBy: "Vince Gilligan",
        directedBy: "Vince Gilligan",
        airDate: "01-20-2008"
    )
}

extension QuoteViewModel {
    static var preview: QuoteViewModel {
        let viewModel = QuoteViewModel()
        viewModel.quote = .mock
        viewModel.character = .mock
        viewModel.fetchStatus = .success
        return viewModel
    }
}
