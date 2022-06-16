//
//  VKLoadViewController.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 16.06.2022.
//

import UIKit

class VKLoadViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        updateFriends()
        updatePhotos()
        updateGroups()
        searchGroups(query: "qwer")

    }


    private func updateFriends() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = VKApi.getFriends.host
        urlComponents.path = VKApi.getFriends.endPoint
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.81") ]
        let request = URLRequest(url: urlComponents.url!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) else { return }

            print(json)
        }
        task.resume()
    }

    private func updatePhotos() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = VKApi.getPhotos.host
        urlComponents.path = VKApi.getPhotos.endPoint
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "album_id", value: "profile"),
            URLQueryItem(name: "v", value: "5.81") ]
        let request = URLRequest(url: urlComponents.url!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) else { return }

            print(json)
        }
        task.resume()
    }

    private func updateGroups() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = VKApi.getGroups.host
        urlComponents.path = VKApi.getGroups.endPoint
        urlComponents.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.81") ]
        let request = URLRequest(url: urlComponents.url!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) else { return }

            print(json)
        }
        task.resume()
    }

    private func searchGroups(query: String) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = VKApi.searchGroups.host
        urlComponents.path = VKApi.searchGroups.endPoint
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "filters", value: "groups"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.81") ]
        let request = URLRequest(url: urlComponents.url!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) else { return }

            print(json)
        }
        task.resume()
    }
}
