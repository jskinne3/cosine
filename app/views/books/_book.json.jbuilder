json.extract! book, :id, :osp_work_id, :title, :authors, :created_at, :updated_at
json.url book_url(book, format: :json)
