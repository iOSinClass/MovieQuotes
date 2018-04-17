//
//  MovieQuotesTableViewController.swift
//  MovieQuotes
//
//  Created by David Fisher on 3/29/18.
//  Copyright © 2018 David Fisher. All rights reserved.
//

import UIKit

class MovieQuotesTableViewController: UITableViewController {
    


  let movieQuoteCellIdentifier = "MovieQuoteCell"
  let noMovieQuotesCellIdentifier = "NoMovieQuotesCell"
  let showDetailSegueIdentifier = "ShowDetailSegue"
  var movieQuotes = [MovieQuote]()

  override func viewDidLoad() {
    super.viewDidLoad()

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem

    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                        target: self,
                                                        action: #selector(showAddDialog))
    movieQuotes.append(MovieQuote(quote: "I'll be back", movie: "The Terminator"))
    movieQuotes.append(MovieQuote(quote: "Yo Adrian!", movie: "Rocky"))
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }

  @objc func showAddDialog() {
    let alertController = UIAlertController(title: "Create a new movie quote",
                                            message: "",
                                            preferredStyle: .alert)
    alertController.addTextField { (textField) in
      textField.placeholder = "Quote"
    }
    alertController.addTextField { (textField) in
      textField.placeholder = "Movie Title"
    }
    let cancelAction = UIAlertAction(title: "Cancel",
                                     style: UIAlertActionStyle.cancel,
                                     handler: nil)
    let createQuoteAction = UIAlertAction(title: "Create Quote",
                                     style: UIAlertActionStyle.default) {
                                      (action) in
                                      let quoteTextField = alertController.textFields![0]
                                      let movieTextField = alertController.textFields![1]
                                      print("quoteTextField = \(quoteTextField.text!)")
                                      print("movieTextField = \(movieTextField.text!)")
                                      let movieQuote = MovieQuote(quote: quoteTextField.text!,
                                                                  movie: movieTextField.text!)
                                      self.movieQuotes.insert(movieQuote, at: 0)
                                      if self.movieQuotes.count == 1 {
                                        self.tableView.reloadData()
                                      } else {
                                        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)],
                                                                  with: UITableViewRowAnimation.top)
                                      }
    }
    alertController.addAction(cancelAction)
    alertController.addAction(createQuoteAction)
    present(alertController, animated: true, completion: nil)
  }

  override func setEditing(_ editing: Bool, animated: Bool) {
    if movieQuotes.count == 0 {
      print("Don't allow editing mode at this time")
      super.setEditing(false, animated: animated)
    } else {
      super.setEditing(editing, animated: animated)
    }
  }

  // MARK: - Table view data source

  //  override func numberOfSections(in tableView: UITableView) -> Int {
  //    return 1
  //  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return max(movieQuotes.count, 1)
  }


  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell: UITableViewCell
    if movieQuotes.count == 0 {
      cell = tableView.dequeueReusableCell(withIdentifier: noMovieQuotesCellIdentifier, for: indexPath)
    } else {
      cell = tableView.dequeueReusableCell(withIdentifier: movieQuoteCellIdentifier, for: indexPath)
      cell.textLabel?.text = movieQuotes[indexPath.row].quote
      cell.detailTextLabel?.text = movieQuotes[indexPath.row].movie
    }
    return cell
  }

  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return movieQuotes.count > 0
  }

  // Override to support editing the table view.
  override func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCellEditingStyle,
                          forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      movieQuotes.remove(at: indexPath.row)
      if movieQuotes.count == 0 {
        tableView.reloadData()
        self.setEditing(false, animated: true)
      } else {
        tableView.deleteRows(at: [indexPath], with: .fade)
      }
    }
  }



  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    if segue.identifier == showDetailSegueIdentifier {
      // Goal: Pass the selected movie quote to the detail view controller.

      if let indexPath = tableView.indexPathForSelectedRow {

        (segue.destination as! MovieQuoteDetailViewController).movieQuote = movieQuotes[indexPath.row]


//        if let detailVC = segue.destination as? MovieQuoteDetailViewController {
//          detailVC.movieQuote = movieQuotes[indexPath.row]
//        }

      }
      
    }
  }


}
