class ApiController < ApplicationController

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

    # Sort the books by freqency of co-assignmens

    # create a hash with (unique) keys of the items and count values
    frequency = new_books.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    # sort the hash by length of values
    sort_hash = Hash[frequency.sort_by {|k,v| v}]
    # get the keys only, in reverse order
    book_keys = sort_hash.keys.reverse

    # Find ISBN of the resultant books, grouped by book
    new_isbns = book_keys.map{|book| book.isbns.map(&:code)}

    render plain: new_isbns.to_json
  end

  def cips
    cips = Syllabus.distinct.pluck(:cip, :field)
    render plain: cips.to_json
  end

  def field
    (render plain: []; return) unless params[:cip]
    syllabus_ids = Syllabus.where(cip: params[:cip]).pluck(:id)
    books = Book.includes(:syllabi).where(syllabi: {id: syllabus_ids})
    # TODO: sort the books by number of syllabi in which they appear, output ISBNs
    render plain: books.map{|b| b.title}
  end

end
