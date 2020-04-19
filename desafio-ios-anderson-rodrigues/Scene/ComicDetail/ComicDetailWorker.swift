//
//  ComicDetailWorker.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 16/04/2020.
//  Copyright (c) 2020 Anderson Rodrigues. All rights reserved.
//

import UIKit

class ComicDetailWorker {
    func fetchComicDetail(character: CharacterMarvel, completion: @escaping(ComicDetailModel.Comic.Response) -> Void) {
        let comicWorker = ComicDetailModel.comicWorker
        comicWorker.setupFetchedResultsController(character: character)
        
        if comicWorker.count() > 0 {
            let data = comicWorker.list()
            let response = ComicDetailModel.Comic.Response(comic: data.first, error: nil)
            completion(response)
        } else {
            APIClient.getAllComics(by: Int(character.id)) { (data, error) in
                guard error == nil else {
                    let response = ComicDetailModel.Comic.Response(comic: nil, error: error!.localizedDescription)
                    completion(response)

                    return
                }

                if let comic = data.sorted().first {
                    comicWorker.create(obj: comic)
                    let response = ComicDetailModel.Comic.Response(comic: comicWorker.list().first, error: nil)
                    completion(response)
                } else {
                    let response = ComicDetailModel.Comic.Response(comic: nil, error: "There's any HQ available for this Character")
                    completion(response)
                }
            }
        }
    }
    
    func fetchCoverImage(request: ComicDetailModel.CoverImage.Request, completion: @escaping(ComicDetailModel.CoverImage.Response) -> Void) {
        
        let comicWorker = ComicDetailModel.comicWorker
        let comic = comicWorker.list().first!

        if let image = comic.thumbnail {
            let response = ComicDetailModel.CoverImage.Response(image: image, error: nil)
            completion(response)
        } else if let url = comic.thumbnailURL {
            APIClient.downloadPosterImage(path: url, size: request.size, ext: request.ext) { (data, error) in

                guard let data = data else {
                    let response = ComicDetailModel.CoverImage.Response(image: nil, error: error!.localizedDescription)
                    completion(response)

                    return
                }

                comic.setValue(data, forKey: "thumbnail")
                comicWorker.update(obj: comic)

                let response = ComicDetailModel.CoverImage.Response(image: data, error: nil)
                completion(response)
            }
        }
    }
}
