class ApiController < ApplicationController
    skip_before_action :check_ui_key

  def coassigned
    # Look up ISBNs from params
    isbns = Isbn.where(code: params[:isbns])
    # Get the books represented by ISBNs
    books = isbns.map{|isbn| isbn.book}
    # Get the syllabi that assign those books
    syllabi = books.map{|book| book.syllabi}.flatten
    # Get all books assigned by those syllabi
    reading_list = syllabi.map{|s| s.books}.flatten
    # Subtract books the user queried with
    new_books = reading_list - books
    # Find ISBN of the resultant books, grouped by book
    new_isbns = new_books.map{|book| book.isbns.map(&:code)}

    # Sort the ISBNs by freqency of co-assignmens

    # create a hash with keys of the items and count values
    frequency = new_isbns.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    # sort the hash by length of values
    sort_hash = Hash[frequency.sort_by {|k,v| v}]
    # get the keys only, in reverse order
    isbn_keys = sort_hash.keys.reverse

    render plain: isbn_keys

  end

end
