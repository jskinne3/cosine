
# The first two books listed, and their ISBNs

pandp = Book.create({title: 'Pride and Prejudice', osp_work_id: 60129543254, authors: 'Jane Austen'})
mgcat = Book.create({title: 'A Museum Guide to Copyright and Trademark', osp_work_id: 1168231295904, authors: 'Brett I Miller, Michael Steven Shapiro, Christine Steiner, American Association of Museums'})

Isbn.create({code: '0340076151', book: pandp})
Isbn.create({code: '0517227851', book: pandp})
Isbn.create({code: '9780517227855', book: pandp})
Isbn.create({code: '1596792493', book: pandp})
Isbn.create({code: '0679601686', book: pandp})
Isbn.create({code: '0140430725', book: pandp})
Isbn.create({code: '0521576547', book: pandp})
Isbn.create({code: '0743487591', book: pandp})
Isbn.create({code: '0192553321', book: pandp})
Isbn.create({code: '0531169944', book: pandp})
Isbn.create({code: '9780531169940', book: pandp})
Isbn.create({code: '0140434267', book: pandp})
Isbn.create({code: '9780307386861', book: pandp})
Isbn.create({code: '0393096688', book: pandp})
Isbn.create({code: '0141439513', book: pandp})
Isbn.create({code: '0895771985', book: pandp})
Isbn.create({code: '0192100262', book: pandp})
Isbn.create({code: '0821916211', book: pandp})
Isbn.create({code: '0521825148', book: pandp})
Isbn.create({code: '9780521825146', book: pandp})
Isbn.create({code: '1593080204', book: pandp})
Isbn.create({code: '0955881862', book: pandp})
Isbn.create({code: '9780955881862', book: pandp})
Isbn.create({code: '0679405429', book: pandp})
Isbn.create({code: '0817216731', book: pandp})
Isbn.create({code: '1857150015', book: pandp})
Isbn.create({code: '1551110288', book: pandp})
Isbn.create({code: '0853435286', book: pandp})
Isbn.create({code: '0712610111', book: pandp})
Isbn.create({code: '0753705176', book: pandp})
Isbn.create({code: '9781843175698', book: pandp})
Isbn.create({code: '1440506604', book: pandp})
Isbn.create({code: '9781440506604', book: pandp})
Isbn.create({code: '0460872125', book: pandp})
Isbn.create({code: '0486440915', book: pandp})
Isbn.create({code: '0764111477', book: pandp})
Isbn.create({code: '0448060329', book: pandp})
Isbn.create({code: '051738589', book: pandp})

Isbn.create({code: '0931201632', book: mgcat})

# Syllabi that assign Pride and Prejudice

ucatb = Syllabus.create({osp_doc_id: 804249806045322, institution: 'University of California, Berkeley', field: 'English Literature', cip: '23'})
uaalr = Syllabus.create({osp_doc_id: 139096810848411, institution: 'University of Arkansas at Little Rock', year: 2007, field: 'English Literature', cip: '23'})

# The second of these syllabi assign also work 137439397900

jsmil = Book.create(title: "Autobiography", osp_work_id: 137439397900, authors: 'John Stuart Mill')

Isbn.create({code: '0140433163', book: jsmil})

# Associate books with syllabi

ucatb.books << pandp
uaalr.books << pandp
uaalr.books << jsmil


