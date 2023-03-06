//
//  Constants.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/11.
//

import Alamofire

var bothEndsConnected = true

let languages = ["KR", "ENG"]
let sortOrder = ["추천", "작품명"]

#if LOCAL_API
let ipAddress = "http://1.2.3.4:5678"
let galleryListAPI = ipAddress + "/gallery/"
let galleryBannerListAPI_forId = ipAddress + "/gallery/banner?galleryId="
let exhibitionListAPI = ipAddress + "/exhibition/"
let exhibitionListAPI_forId = ipAddress + "/exhibition/gallery?id="
let workListAPI = ipAddress + "/work/"
let featuredWorkListAPI = ipAddress + "/work/featured"
let workListAPI_forExhibitionId = ipAddress + "/work/viewOrder?exhibitionId="
let docentTourListAPI = ipAddress + "/docentTour/"
let docentTourListAPI_forDocentTourId = ipAddress + "/docentTour/viewOrder?docentTourId="
let registerUserAppleIdAPI = ipAddress + "/user/registerUserId?loginId="
let getRegisteredUserAPI = ipAddress + "/user/registered?loginId="
let userDocentNoteListAPI = ipAddress + "/user/docentNote?userId="
#elseif DEBUG
let ipAddress = "http://1.2.3.4:5678"
let adminAddress = "http://1.2.3.4:5678"
let exhibitionListAPI = adminAddress + "/aidocent/getExhibitionList"
let workListAPI = ipAddress + "/all/work/artList"
let workListAPI_forExhibitionId = adminAddress + "/aidocent/getExhibitionAndworkList?exhibitionId="
let docentTourListAPI = adminAddress + "/aidocent/getTourAndworkList"
let galleryListAPI = adminAddress + "/aidocent/getGalleryList"
let registerAppUserAPI = adminAddress + "/aidocent/registerAppUser"//
let selectAppUserAPI = adminAddress + "/aidocent/selectAppUser"
let insertAppUserLogAPI = adminAddress + "/aidocent/insertAppUserLog"
let docentNoteTargetIdListAPI = adminAddress + "/aidocent/selectAppUserDistinctTarget"

let apiKeyHeaders: HTTPHeaders = [
    "Accept":"application/json",
    "X-AUTH-TOKEN":"abcdefghijklmnopqrstuvwxyz",
    "Content-Type":"application/json"
]
let apiBody = """
{
      "header":{
      "DATA_TYPE":"abcdefghijklmnopqrstuvwxyz",
      "service": "abcdefghijklmnopqrstuvwxyz"
   }, "dto" :{
         "abcdefghijklmnopqrstuvwxyz": "abcdefghijklmnopqrstuvwxyz"
   }
}
"""
var apiParameters: [String: Any] =
[
    "header":[
        "DATA_TYPE":"abcdefghijklmnopqrstuvwxyz",
        "service":"abcdefghijklmnopqrstuvwxyz"
    ],
    "dto":[
        "abcdefghijklmnopqrstuvwxyz":"abcdefghijklmnopqrstuvwxyz"
    ]
]
#elseif RELEASE
let ipAddress = "http://1.2.3.4:5678"
let adminAddress = "http://1.2.3.4:5678"
let exhibitionListAPI = adminAddress + "/aidocent/getExhibitionList"
let workListAPI = ipAddress + "/all/work/artList"
let workListAPI_forExhibitionId = adminAddress + "/aidocent/getExhibitionAndworkList?exhibitionId="
let docentTourListAPI = adminAddress + "/aidocent/getTourAndworkList"
let galleryListAPI = adminAddress + "/aidocent/getGalleryList"
let registerAppUserAPI = adminAddress + "/aidocent/registerAppUser"
let selectAppUserAPI = adminAddress + "/aidocent/selectAppUser"
let insertAppUserLogAPI = adminAddress + "/aidocent/insertAppUserLog"
let docentNoteTargetIdListAPI = adminAddress + "/aidocent/selectAppUserDistinctTarget"

let apiKeyHeaders: HTTPHeaders = [
    "Accept":"application/json",
    "X-AUTH-TOKEN":"abcdefghijklmnopqrstuvwxyz",
    "Content-Type":"application/json"
]
let apiBody = """
{
      "header":{
      "DATA_TYPE":"abcdefghijklmnopqrstuvwxyz",
      "service": "abcdefghijklmnopqrstuvwxyz"
   }, "dto" :{
         "abcdefghijklmnopqrstuvwxyz": "abcdefghijklmnopqrstuvwxyz"
   }
}
"""
var apiParameters: [String: Any] =
[
    "header":[
        "DATA_TYPE":"abcdefghijklmnopqrstuvwxyz",
        "service":"abcdefghijklmnopqrstuvwxyz"
    ],
    "dto":[
        "abcdefghijklmnopqrstuvwxyz":"abcdefghijklmnopqrstuvwxyz"
    ]
]
#endif

enum ViewName {
    case MainView
    case GalleryView
    case ExhibitionsMenuView
    case WorkView
    case DocentTourView
    case DocentTourDetailView
}

enum TabOrder {
    case firstTab
    case secondTab
}

enum TabAlignment {
    case leading
    case center
    case trailing
}

enum DeeplinkQuery {
    case main
    case gallery
    case exhibition
    case work
    case docentNote
}
