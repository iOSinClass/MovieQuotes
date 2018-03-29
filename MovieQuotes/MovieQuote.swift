//
//  MovieQuote.swift
//  MovieQuotes
//
//  Created by David Fisher on 3/29/18.
//  Copyright © 2018 David Fisher. All rights reserved.
//

import UIKit

class MovieQuote: NSObject {
  var quote: String
  var movie: String

  init(quote: String, movie: String) {
    self.quote = quote
    self.movie = movie
  }
}
