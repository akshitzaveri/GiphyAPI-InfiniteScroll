//
//  GIFImage.swift
//  GiphyAPI-InfiniteScroll
//
//  Created by Akshit Zaveri on 20/06/19.
//  Copyright © 2019 Akshit Zaveri. All rights reserved.
//

import Foundation

struct GIFImageResult: Decodable {
    
    struct Pagination: Decodable {
        var total_count: Int? // Let's assume the total count is less than 2^64 = 1.844674407E19
        var count: Int?
        var offset: Int?
    }
    
    struct Meta: Decodable {
        var status: Int?
        var msg: String?
    }
    
    var data: [GIFImage]?
    var pagination: Pagination?
    var meta: Meta?
}

struct GIFImage: Decodable {
    
    enum TypeEnum: String, Decodable {
        case gif = "gif"
    }
    
    struct RemoteImageResource: Decodable {
        struct Resource: Decodable {
            var url: URL?
            var width: Double?
            var height: Double?
            var size: Double? // in bytes
        }
        
        //Assumption - For now only preview and original is being decoded. In an ideal scenario, we would decode every type of images and use the best image resolution suited for the current device, which could range from iPhone SE to iPad Pro (or even a Mac now! Hail Project Catalyst 😍)
        var preview_gif: Resource?
        var original: Resource?
    }
    
    struct Analytics: Decodable {
        struct AnalyticsURL: Decodable {
            var url: URL?
        }
        var onload: AnalyticsURL?
        var onclick: AnalyticsURL?
        var onsent: AnalyticsURL?
    }
    
    var type: TypeEnum?
    var id: String?
    var import_datetime: String?
    var title: String?
    var images: [RemoteImageResource]
    var analytics: Analytics?
}
