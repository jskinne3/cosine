namespace :populate do
  desc "Populate the database from Open Syllabus data download"

  # rake populate:test
  task test: :environment do
    puts "Testing the ability to open files..."
    file = open('http://johnskinnerportfolio.com/resources/catalog.json/part-00084-4453d4a9-ee1a-433f-8e83-e03ab3824834-c000.json') {|f| f.read }
    puts file.inspect
  end

  # rake populate:catalog
  task catalog: :environment do
    puts "Populating books table from catalog JSON files"

    Isbn.destroy_all
    puts "Destroyed existing ISBNs"
    Book.destroy_all
    puts "Destroyed existing Books"

    100.times do |i|
      code = i.to_s.rjust(2, "0")
      file = "http://johnskinnerportfolio.com/resources/catalog.json/part-000#{code}-4453d4a9-ee1a-433f-8e83-e03ab3824834-c000.json"
      data = open( file ) {|f| f.read }

      puts file
      for line in data.split("\n")
        info = JSON.parse(line)
        unless info['work_isbns'].blank? # don't worry about books missing ISBNs
          begin
            authors = info['authors'].map{|a| "#{a['given_name']} #{a['surname']}" }.join(', ')

            existing_book = Book.where(
              title: info['normalized_title'],
              osp_work_id: info['work_id'].to_i,
              authors: authors
            ).first

            unless existing_book
              book = Book.create(
                title: info['normalized_title'],
                osp_work_id: info['work_id'].to_i,
                authors: authors
              )
              for isbn in info['work_isbns'] 
                isbn.delete!('^0-9,X') # remove suffixes from ISBNs
                Isbn.create(
                  code: isbn,
                  book: book
                )
              end
            end
          rescue
            puts "========================= could not create this book in db ===="
            puts info['normalized_title']
            puts authors
            puts "==============================================================="
            sleep(5)
          end
        end
      end

    end # end dir foreach

  end

  # rake populate:syllabi
  task syllabi: :environment do
    puts "Populating syllabi table from syllabi JSON files"

    Syllabus.destroy_all
    puts "Destroyed existing syllabi"

    100.times do |i|
      code = i.to_s.rjust(2, "0")
      file = "http://johnskinnerportfolio.com/resources/syllabi.json/part-000#{code}-9456a5fd-da80-4b27-95e4-581d97c077a9-c000.json"
      data = open( file ) {|f| f.read }

      puts file
      for line in data.split("\n")
        
        info = JSON.parse(line)

        begin
          existing_syllabus = Syllabus.create(
            osp_doc_id: info['id'],
            institution: info['institution_name'],
            year: info['year'],
            field: (info['field_name'].blank? ? nil : info['field_name']),
            cip: (info['field_code'].blank? ? nil : info['field_code']),
          )
          unless existing_syllabus
            Syllabus.create(
              osp_doc_id: info['id'],
              institution: info['institution_name'],
              year: info['year'],
              field: (info['field_name'].blank? ? nil : info['field_name']),
              cip: (info['field_code'].blank? ? nil : info['field_code']),
            )
          end
        rescue
          puts "===================== could not create this syllabus in db ===="
          puts info['institution_name'] + info['year']
          puts info['field_name']
          puts "==============================================================="
          sleep(5)
        end

      end

    end # end dir foreach

  end

  # rake populate:matches
  task matches: :environment do
    puts "Populating books_syllabi join table from matches JSON files"

    100.times do |i|
      code = i.to_s.rjust(2, "0")
      file = "http://johnskinnerportfolio.com/resources/matches.json/part-000#{code}-ce174801-e480-496b-8f50-448b41e8bedd-c000.json"
      data = open( file ) {|f| f.read }

      puts file
      for line in data.split("\n")

        info = JSON.parse(line)

        begin

          # Find the book referred to in the match
          book = Book.where(osp_work_id: info['work_id'].to_i).first

          # Find the syllabus referred to in the match
          syllabus = Syllabus.where(osp_doc_id: info['doc_id'].to_i).first

          # Associate them, if they were found
          if book && syllabus
            #puts "#{book.title} --- #{syllabus.institution} #{syllabus.year}"
            syllabus.books << book
          end
        rescue
          puts "======================== could not associate these records ===="
          puts "book: " + info['work_id'] + " syllabus: " + info['doc_id']
          puts "==============================================================="
          sleep(5)
        end

      end

    end

  end

end
