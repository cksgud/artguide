//
//  Functions.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/18.
//

import Foundation
import SwiftUI
import Alamofire

#if LOCAL_API
let profileImageNames = [
    "charleyrivers",
    "chilkoottrail",
    "chincoteague",
    "hiddenlake",
    "icybay",
    "lakemcdonald",
    "rainbowlake",
    "silversalmoncreek",
    "stmarylake",
    "turtlerock",
    "twinlake",
    "umbagog"
]

func getRandomProfileImageName() -> String {
    return String(profileImageNames.randomElement()!)
}

func getDistinctAddedIds(_ ids: String, _ addId: Int) -> String {
    let addedIds = ids + String(addId)
    let idsStringArray = addedIds.components(separatedBy: " ")
    var idsIntArray = [Int]()
    var idsIntSet = Set<Int>()
    var distinctAddedIds = ""
    
    for id in idsStringArray {
        if let id = Int(id) {
            idsIntArray.append(id)
        }
    }
    
    for id in idsIntArray {
        idsIntSet.insert(id)
    }
    
    for id in idsIntSet.sorted() {
        distinctAddedIds += "\(String(id)) "
    }
    
    return distinctAddedIds
}

func getGalleryById(id: Int, galleryList: [Gallery]) -> Gallery {
    for gallery in galleryList {
        if gallery.id == id {
            return gallery
        }
    }
    return Gallery()
}

func getExhibitionById(id: Int, exhibitionList: [Exhibition]) -> Exhibition {
    for exhibition in exhibitionList {
        if exhibition.id == id {
            return exhibition
        }
    }
    return Exhibition()
}

func getWorkById(id: Int, workList: [Work]) -> Work {
    for work in workList {
        if work.id == id {
            return work
        }
    }
    return Work()
}

func getSearchedExhibitionList(searchString: String, exhibitionList: [Exhibition]) -> [Exhibition] {
    var searchedExhibitionList = [Exhibition]()
    
    for exhibition in exhibitionList {
        if exhibition.name.range(of: searchString) != nil {
            searchedExhibitionList.append(exhibition)
        } else if exhibition.start_date.range(of: searchString) != nil {
            searchedExhibitionList.append(exhibition)
        } else if exhibition.end_date.range(of: searchString) != nil {
            searchedExhibitionList.append(exhibition)
        } else if exhibition.tags.range(of: searchString) != nil {
            searchedExhibitionList.append(exhibition)
        } else if exhibition.commentary.range(of: searchString) != nil {
            searchedExhibitionList.append(exhibition)
        }
    }
    
    return searchedExhibitionList
}

func getSearchedWorkList(searchString: String, workList: [Work]) -> [Work] {
    var searchedWorkList = [Work]()
    
    for work in workList {
        if work.name.range(of: searchString) != nil {
            searchedWorkList.append(work)
        } else if work.location.range(of: searchString) != nil {
            searchedWorkList.append(work)
        } else if work.commentary.range(of: searchString) != nil {
            searchedWorkList.append(work)
        } else if work.artist_name.range(of: searchString) != nil {
            searchedWorkList.append(work)
        } else if work.tags.range(of: searchString) != nil {
            searchedWorkList.append(work)
        }
    }
    
    return searchedWorkList
}

func getSearchedGalleryList(searchString: String, galleryList: [Gallery]) -> [Gallery] {
    var searchedGalleryList = [Gallery]()
    
    for gallery in galleryList {
        if gallery.name.range(of: searchString) != nil {
            searchedGalleryList.append(gallery)
        } else if gallery.address.range(of: searchString) != nil {
            searchedGalleryList.append(gallery)
        } else if gallery.operation_hours.range(of: searchString) != nil {
            searchedGalleryList.append(gallery)
        }
    }
    
    return searchedGalleryList
}

func getCustomizedScreenWidth(_ originalWidth: Float) -> CGFloat {
    let floatWidth = originalWidth * (UIScreen.screenWidth / 375)
    return CGFloat(floatWidth)
}

func getCustomizedScreenHeight(_ originalHeight: Float) -> CGFloat {
    let floatHeight = originalHeight * (UIScreen.screenHeight / 812)
    return CGFloat(floatHeight)
}

func getTimeNow() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy.MM.dd"
    return dateFormatter.string(from: Date())
}


#else
let profileImageNames = [
    "charleyrivers",
    "chilkoottrail",
    "chincoteague",
    "hiddenlake",
    "icybay",
    "lakemcdonald",
    "rainbowlake",
    "silversalmoncreek",
    "stmarylake",
    "turtlerock",
    "twinlake",
    "umbagog"
]

func getRandomProfileImageName() -> String {
    return String(profileImageNames.randomElement()!)
}

func getDistinctAddedIds(_ ids: String, _ addId: Int) -> String {
    let addedIds = ids + String(addId)
    let idsStringArray = addedIds.components(separatedBy: " ")
    var idsIntArray = [Int]()
    var idsIntSet = Set<Int>()
    var distinctAddedIds = ""
    
    for id in idsStringArray {
        if let id = Int(id) {
            idsIntArray.append(id)
        }
    }
    
    for id in idsIntArray {
        idsIntSet.insert(id)
    }
    
    for id in idsIntSet.sorted() {
        distinctAddedIds += "\(String(id)) "
    }
    
    return distinctAddedIds
}

func getGalleryById(id: Int, galleryList: [Gallery]) -> Gallery {
    for gallery in galleryList {
        if gallery.venue_id == id {
            return gallery
        }
    }
    return Gallery()
}

func getExhibitionById(id: Int, exhibitionList: [Exhibition]) -> Exhibition {
    for exhibition in exhibitionList {
        if exhibition.exhibition_id == id {
            return exhibition
        }
    }
    return Exhibition()
}

func getWorkById(id: Int, workList: [Work]) -> Work {
    for work in workList {
        if work.artwork_id == id {
            return work
        }
    }
    return Work()
}

func getSearchedExhibitionList(searchString: String, exhibitionList: [Exhibition]) -> [Exhibition] {
    var searchedExhibitionList = [Exhibition]()
    
    for exhibition in exhibitionList {
        if exhibition.exhibition_nm.range(of: searchString) != nil {
            searchedExhibitionList.append(exhibition)
        } else if exhibition.exhibition_start_date.range(of: searchString) != nil {
            searchedExhibitionList.append(exhibition)
        } else if exhibition.exhibition_end_date.range(of: searchString) != nil {
            searchedExhibitionList.append(exhibition)
        } else if exhibition.venue_nm.range(of: searchString) != nil {
            searchedExhibitionList.append(exhibition)
        } else if exhibition.exhibition_text.range(of: searchString) != nil {
            searchedExhibitionList.append(exhibition)
        }
    }
    
    return searchedExhibitionList
}

func getSearchedWorkList(searchString: String, workList: [Work]) -> [Work] {
    var searchedWorkList = [Work]()
    
    for work in workList {
        if work.artwork_title.range(of: searchString) != nil {
            searchedWorkList.append(work)
        } else if work.artwork_location.range(of: searchString) != nil {
            searchedWorkList.append(work)
        } else if work.artwork_text.range(of: searchString) != nil {
            searchedWorkList.append(work)
        } else if work.artwork_artist_nm.range(of: searchString) != nil {
            searchedWorkList.append(work)
        } else if work.artwork_tag.range(of: searchString) != nil {
            searchedWorkList.append(work)
        }
    }
    
    return searchedWorkList
}

func getSearchedGalleryList(searchString: String, galleryList: [Gallery]) -> [Gallery] {
    var searchedGalleryList = [Gallery]()
    
    for gallery in galleryList {
        if gallery.venue_nm.range(of: searchString) != nil {
            searchedGalleryList.append(gallery)
        } else if gallery.venue_addr.range(of: searchString) != nil {
            searchedGalleryList.append(gallery)
        } else if gallery.venue_open_time.range(of: searchString) != nil {
            searchedGalleryList.append(gallery)
        }
    }
    
    return searchedGalleryList
}

func getCustomizedScreenWidth(_ originalWidth: Float) -> CGFloat {
    let floatWidth = originalWidth * (UIScreen.screenWidth / 375)
    return CGFloat(floatWidth)
}

func getCustomizedScreenHeight(_ originalHeight: Float) -> CGFloat {
    let floatHeight = originalHeight * (UIScreen.screenHeight / 812)
    return CGFloat(floatHeight)
}

func getTimeNow() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy.MM.dd"
    return dateFormatter.string(from: Date())
}

func httpGetList<T: Codable>(urlString: String) async -> [T] {
    var resultList = [T]()
    
    guard let url = URL(string: urlString) else {
        return resultList
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        if let decodedResponse = try? JSONDecoder().decode([T].self, from: data) {
            resultList = decodedResponse
        }
    } catch {
        print("Invalid data")
    }
    
    return resultList
}

func httpGetPost<T: Codable>(urlString: String, bodyString: String, parameterString: String) async -> [T] {
    var resultList = [T]()
    
    guard let url = URL(string: urlString + parameterString) else {
        return resultList
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJmcm9udCIsInJvbGVzIjpbIlJPTEVfVVNFUiJdLCJpYXQiOjE2NjgzODk1MDQsImV4cCI6NDgyMTk4OTUwNH0.ulGfP01c0uSxfldxWUg-YgWp1FKf_lYWgAOkVs_2KoQ", forHTTPHeaderField: "X-AUTH-TOKEN")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = bodyString.data(using: .utf8)
    
    print("url = \(url)")
    
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        if let decodedResponse = try? JSONDecoder().decode([T].self, from: data) {
            resultList = decodedResponse
            print("resultList = \(resultList)")
        }
    } catch {
        print("Invalid data")
    }
    
    return resultList
}

func alamofireGetList<T: Codable>(urlString: String, header: HTTPHeaders) async -> [T] {
    var resultList = [T]()

    guard let url = URL(string: urlString) else {
        return resultList
    }

    AF.request(url, method: .get).responseDecodable(of: [T].self) { response in
        var parts = response.debugDescription.components(separatedBy: "]")
        parts[7].removeFirst()
        var jsonString = parts[7]
        jsonString += "]"
        let data = jsonString.data(using: .utf8)!
        resultList = try! JSONDecoder().decode([T].self, from: data)
    }

    return resultList
}

func alamofirePost<T: Codable>(urlString: String, header: HTTPHeaders) async -> [T] {
    var resultList = [T]()

    guard let url = URL(string: urlString) else {
        return resultList
    }

    AF.request(url, method: .post).responseDecodable(of: [T].self) { response in
        resultList = response.value ?? [T]()
    }

    return resultList
}
#endif
