class ApiController < ApplicationController

  def isbns
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
    new_isbns = new_books.map{|book| book.isbns.map(&:code)}.uniq

    render plain: new_isbns

  end

end
