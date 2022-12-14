//
//  APICaller.swift
//  SampleD
//
//  Created by Demetrice Sims on 6/9/21.
//  Copyright © 2021 Demetrice Sims. All rights reserved.
//

import Foundation

final class APICaller{
    static let shared = APICaller()
    
    private init(){}
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    enum APIError: Error {
        case failedToGetData
    }
    
    // MARK: - Albums
    
    public func getAlbumDetails(for album: Album, completion: @escaping (Result<AlbumDetailsResponse, Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/albums/" + album.id),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }

                do {
                    let result = try JSONDecoder().decode(AlbumDetailsResponse.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
  
    // MARK: - Playlists
    public func getPlaylistDetails(for playlist: Playlist, completion: @escaping (Result<PlaylistDetailsResponse, Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/playlists/" + playlist.id),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }

                do {
                    let result = try JSONDecoder().decode(PlaylistDetailsResponse.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getCurrentUserPlaylists(completion: @escaping(Result<[Playlist], Error>)-> Void){
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/me/playlists/?limit=50"),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(LibraryPlaylistsResponse.self, from: data)
                    completion(.success(result.items))
                    }
                catch {
                    print(error)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    public func createPlaylist(with name: String, completion: @escaping (Bool) -> Void){
        getCurrentUserProfile { result in
            switch result{
            case .success(let profile):
                let urlString = Constants.baseAPIURL + "/users/{user_id}/playlists"
            case .failure(let error):
                print(error.localizedDescription)
            
            }
        }
        
    }
    public func addTrackToPlaylist(
        track: AudioTrack,
        playlist: Playlist,
        completion: @escaping (Bool) -> Void
    ){
        
    }
    public func removeTrackFromPlaylist(
        track: AudioTrack,
        playlist: Playlist,
        completion: @escaping (Bool) -> Void
    ){
        
    }
    
    
    
    // MARK: - Profile
    public func getCurrentUserProfile(completion: @escaping(Result<UserProfile, Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/me"),
            type: .GET
        ) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error  in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                    }
                    do{
                        let result = try JSONDecoder().decode(UserProfile.self, from: data)
                        completion(.success(result))
                    }
                    catch{
                        print(error.localizedDescription)
                        completion(.failure(error))
                    }
                }
                task.resume()
            }
        }
   
    // MARK: - Browse
    public func getNewReleases(completion: @escaping ((Result<NewReleasesResponse, Error>)) -> Void) {
           createRequest(with: URL(string: Constants.baseAPIURL + "/browse/new-releases?limit=50"), type: .GET) { request in
               let task = URLSession.shared.dataTask(with: request) { data, _, error in
                   guard let data = data, error == nil else {
                       completion(.failure(APIError.failedToGetData))
                       return
                   }

                   do {
                       let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                       completion(.success(result))
                   }
                   catch {
                       completion(.failure(error))
                   }
               }
               task.resume()
           }
       }

    
    public func getFeaturedPlaylists(completion: @escaping ((Result<FeaturedPlaylistsResponse, Error>) -> Void)){
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/browse/featured-playlists?limit=20"),
            type: .GET)
        {
            request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(FeaturedPlaylistsResponse.self, from: data)
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    public func getRecommendations(genres:Set<String>,completion: @escaping ((Result<RecommendationsResponse, Error>) -> Void)) {
        let seeds = genres.joined(separator: ",")
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations?limit=40&seed_genres=\(seeds)"),
                      type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                            guard let data = data, error == nil else{
                                completion(.failure(APIError.failedToGetData))
                                return
                            }
                            do{
                                let result = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
                                completion(.success(result))
                            }
                            catch{
                                completion(.failure(error))
                            }
                        }
                        task.resume()
        }
    }
    public func getRecommendedGenres(completion: @escaping ((Result<RecommendedGenresResponse, Error>) -> Void)) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations/available-genre-seeds"),
                      type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    //MARK: - Category
    public func getCategories(completion: @escaping(Result<[Category], Error>) -> Void){
        createRequest(
            with: URL(string: Constants.baseAPIURL+"/browse/categories?limit=50"),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(AllCategoriesResponse.self, from: data)
                    print(result.categories.items)
                    completion(.success(result.categories.items))
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getCategoryPlaylists(category: Category,completion: @escaping(Result<[Playlist], Error>) -> Void){
        createRequest(
            with: URL(string:
            Constants.baseAPIURL+"/browse/categories/\(category.id)/playlists?limit=50"),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(CategoryPlaylistsResponse.self, from: data)
                    let playlists = result.playlists.items
                    completion(.success(playlists))
                    //JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    // MARK: -Search
    public func search(with query: String, completion: @escaping (Result<[SearchResult], Error>) -> Void) {
           createRequest(
               with: URL(string: Constants.baseAPIURL+"/search?limit=10&type=album,artist,playlist,track&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"),
               type: .GET
           ) { request in
               print(request.url?.absoluteString ?? "none")
               let task = URLSession.shared.dataTask(with: request) { data, _, error in
                   guard let data = data, error == nil else {
                       completion(.failure(APIError.failedToGetData))
                       return
                   }

                   do {
                       let result = try JSONDecoder().decode(SearchResultsResponse.self, from: data)

                       var searchResults: [SearchResult] = []
                       searchResults.append(contentsOf: result.tracks.items.compactMap({ .track(model: $0) }))
                       searchResults.append(contentsOf: result.albums.items.compactMap({ .album(model: $0) }))
                       searchResults.append(contentsOf: result.artists.items.compactMap({ .artist(model: $0) }))
                       searchResults.append(contentsOf: result.playlists.items.compactMap({ .playlist(model: $0) }))

                       completion(.success(searchResults))
                   }
                   catch {
                       completion(.failure(error))
                   }
               }
               task.resume()
           }
       }

    
    // MARK: - Private
    enum HTTPMethod: String {
        case GET
        case POST
    }
    private func createRequest(with url: URL?,
                               type: HTTPMethod,
                               completion: @escaping (URLRequest) -> Void) {
         
        AuthManager.shared.withValidToken{ token in
            guard let apiURL = url else{
                return
            }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)",
                             forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
        
    }
    
}
