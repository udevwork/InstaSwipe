//
//  GithubFetcher.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 23.05.2023.
//

import Foundation



struct GithubAppData: Codable {
    var favoriteCreators: [FavoriteCreator]
    var creatorOfTheWeek: FavoriteCreator
}

struct FavoriteCreator: Codable, Hashable {
    var id: String
    var profileName: String
    var profileDescription: String
    var profileLink: String
    var profileAvatarImageURL: String
    var profileHeaderImageURL: String
    var technicalInfo: String
}


class GithubFetcher {
    

    func getRawTextFromGithub(_ completion: @escaping (GithubAppData?)->()) {
        let urlString = "https://raw.githubusercontent.com/udevwork/InstaSwipeDB/main/data"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
            } else if let data = data {
                do {
                    // Декодирование полученных данных
                    let result = try JSONDecoder().decode(GithubAppData.self, from: data)
                    print(result.favoriteCreators.first!.profileAvatarImageURL)
                    completion(result)
                } catch {
                    print("Error during JSON serialization: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
}

