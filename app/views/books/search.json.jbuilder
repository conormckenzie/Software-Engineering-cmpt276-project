json.books do
   json.array!(@books) do |book|
      json.name book.name
      json.url book_path(book)
   end
end
   