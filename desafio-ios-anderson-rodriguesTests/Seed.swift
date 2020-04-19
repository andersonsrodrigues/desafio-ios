//
//  Seed.swift
//  desafio-ios-anderson-rodriguesTests
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright © 2020 Anderson Rodrigues. All rights reserved.
//

@testable import desafio_ios_anderson_rodrigues
import Foundation

struct Seed {
    struct CharacterJSON {
        static let data = """
        {
            "id": 1010996,
            "name": "Yellowjacket (Rita DeMara)",
            "description": "Rita DeMara, hoping to show off her talent of engineering, stole a copy of the Yellowjacket costume from the Avengers Mansion.",
            "modified": "2014-06-11T15:06:35-0400",
            "thumbnail": {
                "path": "http://i.annihil.us/u/prod/marvel/i/mg/9/f0/5398a8a4b8ca9",
                "extension": "jpg"
            },
            "resourceURI": "http://gateway.marvel.com/v1/public/characters/1010996",
            "comics": {
                "available": 9,
                "collectionURI": "http://gateway.marvel.com/v1/public/characters/1010996/comics",
                "items": [
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/comics/7135",
                        "name": "Avengers (1963) #264"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/comics/37633",
                        "name": "Chaos War: Avengers (Trade Paperback)"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/comics/37064",
                        "name": "Chaos War: Dead Avengers (2010) #1"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/comics/37085",
                        "name": "Chaos War: Dead Avengers (2010) #2"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/comics/37084",
                        "name": "Chaos War: Dead Avengers (2010) #3"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/comics/61801",
                        "name": "Guardians of the Galaxy (1990) #34"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/comics/62868",
                        "name": "Guardians of the Galaxy (1990) #51"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/comics/62873",
                        "name": "Guardians of the Galaxy (1990) #56"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/comics/62877",
                        "name": "Guardians of the Galaxy (1990) #60"
                    }
                ],
                "returned": 9
            },
            "series": {
                "available": 4,
                "collectionURI": "http://gateway.marvel.com/v1/public/characters/1010996/series",
                "items": [
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/series/1991",
                        "name": "Avengers (1963 - 1996)"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/series/13527",
                        "name": "Chaos War: Avengers (2010)"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/series/13257",
                        "name": "Chaos War: Dead Avengers (2010)"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/series/19019",
                        "name": "Guardians of the Galaxy (1990 - 1994)"
                    }
                ],
                "returned": 4
            },
            "stories": {
                "available": 9,
                "collectionURI": "http://gateway.marvel.com/v1/public/characters/1010996/stories",
                "items": [
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/stories/14809",
                        "name": "Avengers (1963) #264",
                        "type": "cover"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/stories/82163",
                        "name": "Cover #82163",
                        "type": "cover"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/stories/82164",
                        "name": "Interior #82164",
                        "type": "interiorStory"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/stories/82201",
                        "name": "Chaos War: Dead Avengers (2010) #3",
                        "type": "cover"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/stories/82203",
                        "name": "Chaos War: Dead Avengers (2010) #2",
                        "type": "cover"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/stories/136622",
                        "name": "interior to Guardians of the Galaxy #34",
                        "type": "interiorStory"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/stories/140277",
                        "name": "cover to Guardians of the Galaxy (1990) #51",
                        "type": "cover"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/stories/140291",
                        "name": "cover to Guardians of the Galaxy (1990) #56",
                        "type": "cover"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/stories/140299",
                        "name": "cover to Guardians of the Galaxy (1990) #60",
                        "type": "cover"
                    }
                ],
                "returned": 9
            },
            "events": {
                "available": 1,
                "collectionURI": "http://gateway.marvel.com/v1/public/characters/1010996/events",
                "items": [
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/events/296",
                        "name": "Chaos War"
                    }
                ],
                "returned": 1
            },
            "urls": [
                {
                    "type": "detail",
                    "url": "http://marvel.com/characters/2636/yellowjacket?utm_campaign=apiRef&utm_source=fa3b948c912647967dcfa257186c2c00"
                },
                {
                    "type": "wiki",
                    "url": "http://marvel.com/universe/Yellowjacket_%28Rita_DeMara%29?utm_campaign=apiRef&utm_source=fa3b948c912647967dcfa257186c2c00"
                },
                {
                    "type": "comiclink",
                    "url": "http://marvel.com/comics/characters/1010996/yellowjacket_rita_demara?utm_campaign=apiRef&utm_source=fa3b948c912647967dcfa257186c2c00"
                }
            ]
        }
        """.data(using: .utf8)!
    }
    struct ComicJSON {
        static let data = """
        {
            "id": 22506,
            "digitalId": 10949,
            "title": "Avengers: The Initiative (2007) #19",
            "issueNumber": 19,
            "variantDescription": "",
            "description": "Join 3-D MAN, CLOUD 9, KOMODO, HARDBALL, and heroes around America in the battle that will decide the fate of the planet and the future of the Initiative program. Will the Kill Krew Army win the day?",
            "modified": "2015-10-27T16:38:23-0400",
            "isbn": "",
            "upc": "5960606084-01911",
            "diamondCode": "SEP082362",
            "ean": "",
            "issn": "",
            "format": "Comic",
            "pageCount": 32,
            "textObjects": [
                {
                    "type": "issue_preview_text",
                    "language": "en-us",
                    "text": "Join 3-D MAN, CLOUD 9, KOMODO, HARDBALL, and heroes around America in the battle that will decide the fate of the planet and the future of the Initiative program. Will the Kill Krew Army win the day?"
                },
                {
                    "type": "issue_solicit_text",
                    "language": "en-us",
                    "text": "SECRET INVASION Tie-In!\r<br>\"V-S DAY\"\r<br>It's been leading to this since the Hank Pym Skrull first came up with the idea for a Fifty State Initiative.  This is the final assault in the Secret Invasion, a nation-wide plan that will test the limits of 3-D MAN'S superhuman militia, THE KILL KREW ARMY! Join 3-D MAN, CLOUD 9, KOMODO, HARDBALL, and heroes around America in the battle that will decide the fate of the planet and the future of the Initiative program.  Win or lose, there's no turning back.  After today, everything changes.\r<br>Rated T+ ...$2.99\r<br>"
                }
            ],
            "resourceURI": "http://gateway.marvel.com/v1/public/comics/22506",
            "urls": [
                {
                    "type": "detail",
                    "url": "http://marvel.com/comics/issue/22506/avengers_the_initiative_2007_19?utm_campaign=apiRef&utm_source=fa3b948c912647967dcfa257186c2c00"
                },
                {
                    "type": "purchase",
                    "url": "http://comicstore.marvel.com/Avengers-The-Initiative-19/digital-comic/10949?utm_campaign=apiRef&utm_source=fa3b948c912647967dcfa257186c2c00"
                },
                {
                    "type": "reader",
                    "url": "http://marvel.com/digitalcomics/view.htm?iid=10949&utm_campaign=apiRef&utm_source=fa3b948c912647967dcfa257186c2c00"
                },
                {
                    "type": "inAppLink",
                    "url": "https://applink.marvel.com/issue/10949?utm_campaign=apiRef&utm_source=fa3b948c912647967dcfa257186c2c00"
                }
            ],
            "series": {
                "resourceURI": "http://gateway.marvel.com/v1/public/series/1945",
                "name": "Avengers: The Initiative (2007 - 2010)"
            },
            "variants": [],
            "collections": [],
            "collectedIssues": [],
            "dates": [
                {
                    "type": "onsaleDate",
                    "date": "2008-12-17T00:00:00-0500"
                },
                {
                    "type": "focDate",
                    "date": "2008-11-27T00:00:00-0500"
                },
                {
                    "type": "unlimitedDate",
                    "date": "2010-02-23T00:00:00-0500"
                },
                {
                    "type": "digitalPurchaseDate",
                    "date": "2011-08-09T00:00:00-0400"
                }
            ],
            "prices": [
                {
                    "type": "printPrice",
                    "price": 2.99
                },
                {
                    "type": "digitalPurchasePrice",
                    "price": 1.99
                }
            ],
            "thumbnail": {
                "path": "http://i.annihil.us/u/prod/marvel/i/mg/d/03/58dd080719806",
                "extension": "jpg"
            },
            "images": [
                {
                    "path": "http://i.annihil.us/u/prod/marvel/i/mg/d/03/58dd080719806",
                    "extension": "jpg"
                }
            ],
            "creators": {
                "available": 9,
                "collectionURI": "http://gateway.marvel.com/v1/public/comics/22506/creators",
                "items": [
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/creators/2133",
                        "name": "Tom Brevoort",
                        "role": "editor"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/creators/452",
                        "name": "Virtual Calligr",
                        "role": "letterer"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/creators/12581",
                        "name": "Vc Chris Eliopoulos",
                        "role": "letterer"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/creators/1400",
                        "name": "Bong Dazo",
                        "role": "penciller"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/creators/11765",
                        "name": "Christos Gage",
                        "role": "writer"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/creators/12983",
                        "name": "Dan Slott",
                        "role": "writer"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/creators/8706",
                        "name": "Jay David Ramos",
                        "role": "colorist"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/creators/500",
                        "name": "Christopher Sotomayor",
                        "role": "colorist"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/creators/8584",
                        "name": "Harvey Tolibao",
                        "role": "inker"
                    }
                ],
                "returned": 9
            },
            "characters": {
                "available": 8,
                "collectionURI": "http://gateway.marvel.com/v1/public/comics/22506/characters",
                "items": [
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/characters/1011334",
                        "name": "3-D Man"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/characters/1010802",
                        "name": "Ant-Man (Eric O'Grady)"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/characters/1009165",
                        "name": "Avengers"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/characters/1009284",
                        "name": "Dum Dum Dugan"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/characters/1011490",
                        "name": "Hank Pym"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/characters/1010821",
                        "name": "Hardball"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/characters/1009376",
                        "name": "Jocasta"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/characters/1010818",
                        "name": "Komodo (Melati Kusuma)"
                    }
                ],
                "returned": 8
            },
            "stories": {
                "available": 2,
                "collectionURI": "http://gateway.marvel.com/v1/public/comics/22506/stories",
                "items": [
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/stories/49888",
                        "name": "AVENGERS: THE INITIATIVE (2007) #19",
                        "type": "cover"
                    },
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/stories/49889",
                        "name": "Avengers: The Initiative (2007) #19 - Int",
                        "type": "interiorStory"
                    }
                ],
                "returned": 2
            },
            "events": {
                "available": 1,
                "collectionURI": "http://gateway.marvel.com/v1/public/comics/22506/events",
                "items": [
                    {
                        "resourceURI": "http://gateway.marvel.com/v1/public/events/269",
                        "name": "Secret Invasion"
                    }
                ],
                "returned": 1
            }
        }
        """.data(using: .utf8)!
    }
    struct CharacterSeed {
        static let a = CharacterData(id: 1, name: "Hulk", description: "This is Hulk", thumbnail: ImageData(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", extension: "jpg"), comics: nil)
        static let b = CharacterData(id: 2, name: "Spider Man", description: "Look it's spider man", thumbnail: ImageData(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", extension: "jpg"), comics: nil)
    }
    struct ComicSeed {
        static let a = ComicData(id: 1, title: "AB", description: "Uma descrição", prices: [PriceData(type: "reais", price: 150.0), PriceData(type: "reais", price: 300.0), PriceData(type: "reais", price: 285.4)], thumbnail: ImageData(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", extension: "jpg"))
        static let b = ComicData(id: 2, title: "Avengers: Endgame", description: "Uma descrição", prices: [PriceData(type: "reais", price: 240.0), PriceData(type: "reais", price: 580.0), PriceData(type: "reais", price: 285.4)], thumbnail: ImageData(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", extension: "jpg"))
        static let c = ComicData(id: 3, title: "Avengers: Infinity War", description: "Uma descrição", prices: [PriceData(type: "reais", price: 300.0), PriceData(type: "reais", price: 450.0), PriceData(type: "reais", price: 55.4)], thumbnail: ImageData(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", extension: "jpg"))
    }
}
