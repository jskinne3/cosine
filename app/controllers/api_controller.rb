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
    cips = Syllabus.distinct.pluck(:cip, :field).reject{|e| e[0].nil?}
    json = cips.map{|e| {cip: e[0], field: e[1]}}.to_json
    render plain: json
  end

  def field
    # Supress nil CIP results
    (render plain: []; return) unless params[:cip]
    # Get ids for all the syllabi within the field, designated by CIP code
    syllabus_ids = Syllabus.where(cip: params[:cip]).pluck(:id)
    # Get all the books assigned by those syllabi
    books = Book.includes(:syllabi, :isbns).where(syllabi: {id: syllabus_ids})
    # Create book data structure to output
    books_hashes = books.map{|b| {title: b.title, isbns: b.isbns.map{|i|i.code}, syllabi: b.syllabi.length}}
    # Sort the output structure
    books_hashes.sort!{|a,b| b[:syllabi] <=> a[:syllabi]}
    
    render plain: books_hashes.to_json
  end

end
