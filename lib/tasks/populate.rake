namespace :populate do
  desc "Populate the database from Open Syllabus data download"

  # rake populate:catalog
  task catalog: :environment do
    puts "Populating books table from catalog JSON files"

    file = '../../Desktop/osp-commercial-sample/2.0/catalog.json/part-00000-4453d4a9-ee1a-433f-8e83-e03ab3824834-c000.json'

    Isbn.destroy_all
    Book.destroy_all

    File.open(file).each do |line|
      
      info = JSON.parse(line)
      unless info['work_isbns'].blank? # don't worry about books missing ISBNs
        book = Book.create(
          title: info['normalized_title'],
          osp_work_id: info['work_id'].to_i,
          authors: info['authors'].map{|a| "#{a['given_name']} #{a['surname']}" }.join(', ')
        )
        for isbn in info['work_isbns'] 
          isbn.delete!('^0-9,X') # remove suffixes from ISBNs
          Isbn.create(
            code: isbn,
            book: book
          )
        end
      end
    end

  end

end
