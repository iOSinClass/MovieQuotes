//
//  MovieQuote.swift
//  MovieQuotes
//
//  Created by David Fisher on 3/29/18.
//  Copyright © 2018 David Fisher. All rights reserved.
//

import UIKit

class MovieQuote: NSObject {
    var id: String?
  var quote: String
  var movie: String
    var created: Date?

  init(quote: String, movie: String) {
    self.quote = quote
    self.movie = movie
    //self.created = Date()
  }
}
