//
//  GIFImage.swift
//  GiphyAPI-InfiniteScroll
//
//  Created by Akshit Zaveri on 20/06/19.
//  Copyright © 2019 Akshit Zaveri. All rights reserved.
//

import Foundation

/*
 {
 "data": [
 {
     "type": "gif",
     "id": "xT9IgG50Fb7Mi0prBC",
     "slug": "hello-hi-wave-xT9IgG50Fb7Mi0prBC",
     "url": "https://giphy.com/gifs/hello-hi-wave-xT9IgG50Fb7Mi0prBC",
     "bitly_gif_url": "https://gph.is/2fBD5dc",
     "bitly_url": "https://gph.is/2fBD5dc",
     "embed_url": "https://giphy.com/embed/xT9IgG50Fb7Mi0prBC",
     "username": "",
     "source": "https://www.reactiongifs.com/forrest/",
     "rating": "g",
     "content_url": "",
     "source_tld": "www.reactiongifs.com",
     "source_post_url": "https://www.reactiongifs.com/forrest/",
     "is_sticker": 0,
     "import_datetime": "2017-09-20 19:19:27",
     "trending_datetime": "2019-04-10 02:45:01",
     "images": {
     "fixed_height_still": {
         "url": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/200_s.gif?cid=50abfb485d0ace2a386854444986ed16&rid=200_s.gif",
         "width": "400",
         "height": "200",
         "size": "31769"
         },
         "original_still": {
         "url": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/giphy_s.gif?cid=50abfb485d0ace2a386854444986ed16&rid=giphy_s.gif",
         "width": "400",
         "height": "200",
         "size": "31769"
         },
         "fixed_width": {
         "url": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/200w.gif?cid=50abfb485d0ace2a386854444986ed16&rid=200w.gif",
         "width": "200",
         "height": "100",
         "size": "521339",
         "mp4": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/200w.mp4?cid=50abfb485d0ace2a386854444986ed16&rid=200w.mp4",
         "mp4_size": "51624",
         "webp": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/200w.webp?cid=50abfb485d0ace2a386854444986ed16&rid=200w.webp",
         "webp_size": "229006"
         },
         "fixed_height_small_still": {
         "url": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/100_s.gif?cid=50abfb485d0ace2a386854444986ed16&rid=100_s.gif",
         "width": "200",
         "height": "100",
         "size": "13167"
         },
         "fixed_height_downsampled": {
         "url": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/200_d.gif?cid=50abfb485d0ace2a386854444986ed16&rid=200_d.gif",
         "width": "400",
         "height": "200",
         "size": "286400",
         "webp": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/200_d.webp?cid=50abfb485d0ace2a386854444986ed16&rid=200_d.webp",
         "webp_size": "76404"
         },
         "preview": {
         "width": "196",
         "height": "98",
         "mp4": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/giphy-preview.mp4?cid=50abfb485d0ace2a386854444986ed16&rid=giphy-preview.mp4",
         "mp4_size": "22841"
         },
         "fixed_height_small": {
         "url": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/100.gif?cid=50abfb485d0ace2a386854444986ed16&rid=100.gif",
         "width": "200",
         "height": "100",
         "size": "521339",
         "mp4": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/100.mp4?cid=50abfb485d0ace2a386854444986ed16&rid=100.mp4",
         "mp4_size": "50958",
         "webp": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/100.webp?cid=50abfb485d0ace2a386854444986ed16&rid=100.webp",
         "webp_size": "229006"
         },
         "downsized_still": {
         "url": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/giphy-downsized_s.gif?cid=50abfb485d0ace2a386854444986ed16&rid=giphy-downsized_s.gif",
         "width": "400",
         "height": "200",
         "size": "31769"
         },
         "downsized": {
         "url": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/giphy-downsized.gif?cid=50abfb485d0ace2a386854444986ed16&rid=giphy-downsized.gif",
         "width": "400",
         "height": "200",
         "size": "1532237"
         },
         "downsized_large": {
         "url": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/giphy.gif?cid=50abfb485d0ace2a386854444986ed16&rid=giphy.gif",
         "width": "400",
         "height": "200",
         "size": "1532237"
         },
         "fixed_width_small_still": {
         "url": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/100w_s.gif?cid=50abfb485d0ace2a386854444986ed16&rid=100w_s.gif",
         "width": "100",
         "height": "50",
         "size": "4455"
         },
         "preview_webp": {
         "url": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/giphy-preview.webp?cid=50abfb485d0ace2a386854444986ed16&rid=giphy-preview.webp",
         "width": "210",
         "height": "105",
         "size": "49602"
         },
         "fixed_width_still": {
         "url": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/200w_s.gif?cid=50abfb485d0ace2a386854444986ed16&rid=200w_s.gif",
         "width": "200",
         "height": "100",
         "size": "13167"
         },
         "fixed_width_small": {
         "url": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/100w.gif?cid=50abfb485d0ace2a386854444986ed16&rid=100w.gif",
         "width": "100",
         "height": "50",
         "size": "140692",
         "mp4": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/100w.mp4?cid=50abfb485d0ace2a386854444986ed16&rid=100w.mp4",
         "mp4_size": "19402",
         "webp": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/100w.webp?cid=50abfb485d0ace2a386854444986ed16&rid=100w.webp",
         "webp_size": "82266"
         },
         "downsized_small": {
         "width": "360",
         "height": "180",
         "mp4": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/giphy-downsized-small.mp4?cid=50abfb485d0ace2a386854444986ed16&rid=giphy-downsized-small.mp4",
         "mp4_size": "63508"
         },
         "fixed_width_downsampled": {
         "url": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/200w_d.gif?cid=50abfb485d0ace2a386854444986ed16&rid=200w_d.gif",
         "width": "200",
         "height": "100",
         "size": "78137",
         "webp": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/200w_d.webp?cid=50abfb485d0ace2a386854444986ed16&rid=200w_d.webp",
         "webp_size": "26802"
         },
         "downsized_medium": {
         "url": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/giphy.gif?cid=50abfb485d0ace2a386854444986ed16&rid=giphy.gif",
         "width": "400",
         "height": "200",
         "size": "1532237"
         },
         "original": {
         "url": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/giphy.gif?cid=50abfb485d0ace2a386854444986ed16&rid=giphy.gif",
         "width": "400",
         "height": "200",
         "size": "1532237",
         "frames": "52",
         "mp4": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/giphy.mp4?cid=50abfb485d0ace2a386854444986ed16&rid=giphy.mp4",
         "mp4_size": "188667",
         "webp": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/giphy.webp?cid=50abfb485d0ace2a386854444986ed16&rid=giphy.webp",
         "webp_size": "653964",
         "hash": "dea757acbccd153e3a43a0c943211e5b"
         },
         "fixed_height": {
         "url": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/200.gif?cid=50abfb485d0ace2a386854444986ed16&rid=200.gif",
         "width": "400",
         "height": "200",
         "size": "1725226",
         "mp4": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/200.mp4?cid=50abfb485d0ace2a386854444986ed16&rid=200.mp4",
         "mp4_size": "130534",
         "webp": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/200.webp?cid=50abfb485d0ace2a386854444986ed16&rid=200.webp",
         "webp_size": "653964"
         },
         "looping": {
         "mp4": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/giphy-loop.mp4?cid=50abfb485d0ace2a386854444986ed16&rid=giphy-loop.mp4",
         "mp4_size": "1809441"
         },
         "original_mp4": {
         "width": "480",
         "height": "240",
         "mp4": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/giphy.mp4?cid=50abfb485d0ace2a386854444986ed16&rid=giphy.mp4",
         "mp4_size": "188667"
         },
         "preview_gif": {
         "url": "https://media2.giphy.com/media/xT9IgG50Fb7Mi0prBC/giphy-preview.gif?cid=50abfb485d0ace2a386854444986ed16&rid=giphy-preview.gif",
         "width": "136",
         "height": "68",
         "size": "49485"
         },
         "480w_still": {
         "url": "https://media1.giphy.com/media/xT9IgG50Fb7Mi0prBC/480w_s.jpg?cid=50abfb485d0ace2a386854444986ed16&rid=480w_s.jpg",
         "width": "480",
         "height": "240"
         }
         },
         "title": "tom hanks hello GIF",
         "analytics": {
         "onload": {
         "url": "https://giphy-analytics.giphy.com/simple_analytics?response_id=5d0ace2a386854444986ed16&event_type=GIF_SEARCH&gif_id=xT9IgG50Fb7Mi0prBC&action_type=SEEN"
         },
         "onclick": {
         "url": "https://giphy-analytics.giphy.com/simple_analytics?response_id=5d0ace2a386854444986ed16&event_type=GIF_SEARCH&gif_id=xT9IgG50Fb7Mi0prBC&action_type=CLICK"
         },
         "onsent": {
         "url": "https://giphy-analytics.giphy.com/simple_analytics?response_id=5d0ace2a386854444986ed16&event_type=GIF_SEARCH&gif_id=xT9IgG50Fb7Mi0prBC&action_type=SENT"
         }
         }
         }
     ],
     "pagination": {
         "total_count": 18692,
         "count": 1,
         "offset": 1
     },
     "meta": {
         "status": 200,
         "msg": "OK",
         "response_id": "5d0ace2a386854444986ed16"
     }
 }
 */

struct GIFImageResponse: Decodable {
    
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
