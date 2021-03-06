//
//  RssProcess.swift
//  ULima
//
//  Created by Gabriel Lanata on 1/9/16.
//  Copyright © 2016 Universidad de Lima. All rights reserved.
//

import Foundation
import AEXML

public func RssProcess(loadedValue: AEXMLDocument) throws -> RssChannel {
    return try RssChannel(channelXml: loadedValue.root["channel"])
}

public func RssProcess(loadedValue: Data) throws -> RssChannel {
    return try RssProcess(loadedValue: try XmlProcess(loadedValue))
}

public enum RssProcessError: Error {
    case emptyResponse, missingParameters
}

// MARK: RSS Objects

open class RssChannel {
    
    static var dateFormatString = "EEE, dd MMM yyyy HH:mm:ss ZZZ"
    
    open class ImageInfo {
        
        open var rawXml: AEXMLElement?
        
        open var title: String
        open var link: URL
        open var url: URL
        
        public init(title: String, link: URL, url: URL) {
            self.title = title
            self.link = link
            self.url = url
        }
        
        public convenience init(channelImageXml: AEXMLElement) throws {
            guard let title = channelImageXml["title"].value?.cleaned(),
                let linkString = channelImageXml["link"].value, let link = URL(string: linkString),
                let urlString = channelImageXml["url"].value, let url = URL(string: urlString) else {
                    throw RssProcessError.missingParameters
            }
            self.init(title: title, link: link, url: url)
            self.rawXml = channelImageXml
        }
        
    }
    
    open class Item {
        
        open class Enclosure {
            
            open var rawXml: AEXMLElement?
            
            open var url: URL
            open var length: String
            open var type: String
            
            public init(url: URL, length: String, type: String) {
                self.url = url
                self.length = length
                self.type = type
            }
            
            public convenience init(enclosureXml: AEXMLElement) throws {
                guard let urlString = enclosureXml.attributes["url"], let url = URL(string: urlString),
                    let length = enclosureXml.attributes["length"], let type = enclosureXml.attributes["type"] else {
                        throw RssProcessError.missingParameters
                }
                self.init(url: url, length: length, type: type)
                self.rawXml = enclosureXml
            }
            
        }
        
        open var rawXml: AEXMLElement?
        
        open var title: String
        open var description: String
        open var link: URL
        
        open var author: String?
        open var category: String?
        open var comments: URL?
        open var enclosure: Enclosure?
        open var pubDate: Date?
        
        public init(title: String, description: String, link: URL) {
            self.title = title
            self.description = description
            self.link = link
        }
        
        public convenience init(itemXml: AEXMLElement) throws {
            guard let title = itemXml["title"].value?.cleaned(), let description = itemXml["description"].value?.cleaned(),
                let linkString = itemXml["link"].value, let link = URL(string: linkString) else {
                    throw RssProcessError.missingParameters
            }
            self.init(title: title, description: description, link: link)
            self.rawXml = itemXml
            self.author = itemXml["author"].value?.cleaned()
            self.category = itemXml["category"].value?.cleaned()
            self.comments = itemXml["comments"].value.flatMap({ URL(string: $0) })
            self.enclosure = itemXml["enclosure"].first.flatMap({ try? Enclosure(enclosureXml: $0) })
            if let dateString = itemXml["pubDate"].value {
                self.pubDate = try? Date(string: dateString, format: RssChannel.dateFormatString, locale: "en_US_POSIX")
            }
        }
        
    }
    
    open var rawXml: AEXMLElement?
    
    open var title: String
    open var description: String
    open var link: URL
    
    open var category:  String?
    open var copyright: String?
    open var language:  String?
    open var imageInfo: ImageInfo?
    
    open var items: [Item] = []
    
    public init(title: String, description: String, link: URL) {
        self.title = title
        self.description = description
        self.link = link
    }
    
    public convenience init(channelXml: AEXMLElement) throws {
        
        guard channelXml.xml.length > 20 else {
            throw RssProcessError.emptyResponse
        }
        
        guard let title = channelXml["title"].value?.cleaned(),
            let linkString = channelXml["link"].value, let link = URL(string: linkString) else {
                throw RssProcessError.missingParameters
        }
        let description = channelXml["description"].value ?? ""
        
        self.init(title: title, description: description, link: link)
        self.rawXml    = channelXml
        self.category  = channelXml["category"].value?.cleaned()
        self.copyright = channelXml["copyright"].value?.cleaned()
        self.language  = channelXml["language"].value?.cleaned()
        self.imageInfo = channelXml["image"].first.flatMap({ try? ImageInfo(channelImageXml: $0) })
        self.items     = try channelXml["item"].all?.flatMap({ try Item(itemXml: $0) }) ?? []
    }
    
}
