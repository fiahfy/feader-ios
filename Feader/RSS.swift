//
//  RSS.swift
//  Feader
//
//  Created by fiahfy on 2017/12/05.
//  Copyright © 2017年 fiahfy. All rights reserved.
//

import Foundation

struct RSS: Codable {
    struct Feed: Codable {
        struct Entry: Codable {
            struct Title: Codable {
                let text: String
                private enum CodingKeys: String, CodingKey {
                    case text = "$t"
                }
            }
            struct Link: Codable {
                let rel: String
                let href: String
            }
            let title: Title
            let links: [Link]
            var permalink: String? {
                return links.filter({ $0.rel == "alternate" }).first?.href
            }
            private enum CodingKeys: String, CodingKey {
                case title
                case links = "link"
            }
        }
        let entries: [Entry]
        private enum CodingKeys: String, CodingKey {
            case entries = "entry"
        }
    }
    let encoding: String
    let version: String
    let feed: Feed
}
