namespace :populate do
  desc "Populate the database from Open Syllabus data download"

  # rake populate:enumerate
  task enumerate: :environment do 
    puts "Items in data directory:"
    Dir.foreach('data') do |filename|
      puts filename
    end

  end

  # rake populate:catalog
  task catalog: :environment do
    puts "Populating books table from catalog JSON files"

    Isbn.destroy_all
    Book.destroy_all

    Dir.foreach('../../Desktop/osp-commercial-sample/2.0/catalog.json/') do |filename|
      next if filename == '.' or filename == '..' or filename == '_SUCCESS' or filename == '.DS_Store'

      puts filename
      file = '../../Desktop/osp-commercial-sample/2.0/catalog.json/' + filename

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

    end # end dir foreach

  end

  # rake populate:syllabi
  task syllabi: :environment do
    puts "Populating syllabi table from catalog JSON files"

    Syllabus.destroy_all

    Dir.foreach('../../Desktop/osp-commercial-sample/2.0/syllabi.json/') do |filename|
      next if filename == '.' or filename == '..' or filename == '_SUCCESS' or filename == '.DS_Store'

      puts filename
      file = '../../Desktop/osp-commercial-sample/2.0/syllabi.json/' + filename

      File.open(file).each do |line|
        
        info = JSON.parse(line)
        Syllabus.create(
          osp_doc_id: info['id'],
          institution: info['institution_name'],
          year: info['year'],
          field: (info['field_name'].blank? ? nil : info['field_name']),
          cip: (info['field_code'].blank? ? nil : info['field_code']),
        )

      end

    end # end dir foreach

  end

  # rake populate:matches
  task matches: :environment do
    puts "Populating books_syllabi join table from catalog JSON files"

    Dir.foreach('../../Desktop/osp-commercial-sample/2.0/matches.json/') do |filename|
      next if filename == '.' or filename == '..' or filename == '_SUCCESS' or filename == '.DS_Store'

      file = '../../Desktop/osp-commercial-sample/2.0/matches.json/' + filename

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

end
