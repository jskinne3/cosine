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

  # rake populate:syllabi
  task syllabi: :environment do
    puts "Populating syllabi table from catalog JSON files"

    file = '../../Desktop/osp-commercial-sample/2.0/syllabi.json/part-00000-9456a5fd-da80-4b27-95e4-581d97c077a9-c000.json'

    Syllabus.destroy_all

    File.open(file).each do |line|
      
      info = JSON.parse(line)
      Syllabus.create(
        osp_doc_id: info['id'],
        institution: info['institution_name'],
        year: info['year']
      )

    end

  end

  # rake populate:matches
  task matches: :environment do
    puts "Populating books_syllabi join table from catalog JSON files"

    file = '../../Desktop/osp-commercial-sample/2.0/matches.json/part-00000-ce174801-e480-496b-8f50-448b41e8bedd-c000.json'

    File.open(file).each do |line|
      info = JSON.parse(line)

      # Find the book referred to in the match
      book = Book.where(osp_work_id: info['work_id'].to_i).first

      # Find the syllabus referred to in the match
      syllabus = Syllabus.where(osp_doc_id: info['doc_id'].to_i).first

      # Associate them, if they were found
      if book && syllabus
        puts "#{book.title} --- #{syllabus.institution} #{syllabus.year}"
        syllabus.books << book
      end

    end

  end

end
