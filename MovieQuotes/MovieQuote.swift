//
//  MovieQuote.swift
//  MovieQuotes
//
//  Created by David Fisher on 3/29/18.
//  Copyright © 2018 David Fisher. All rights reserved.
//

import UIKit
import Firebase

class MovieQuote: NSObject {
    var id: String?
  var quote: String
  var movie: String
    var created: Date!

  init(quote: String, movie: String) {
    self.quote = quote
    self.movie = movie
    self.created = Date()
  }
    
    init(documentSnapshot: DocumentSnapshot) {
        self.id = documentSnapshot.documentID
        let data = documentSnapshot.data()!
        self.quote = data["quote"] as! String
        self.movie = data["movie"] as! String
        self.created = data["created"] as! Date
    }
    
    var data: [String: Any] {
    return ["quote": self.quote,
            "movie": self.movie,
            "created": self.created]
    }
}
