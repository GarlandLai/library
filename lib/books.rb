class Book
  attr_reader :id
  attr_accessor :title
  @@attr = []

  def initialize(attr)
    @title = attr.fetch(:title)
    @id = attr.fetch(:id)
  end


def save
  result = DB.exec("INSERT INTO books (title) VALUES ('#{@title}'}) RETURNING id;")
  @id = result.first().fetch("id").to_i
end

  def self.all
    returned_books = DB.exec("SELECT * FROM books ORDER BY title;")
    books = []
    returned_books.each() do |book|
      title = book.fetch("title")
      id = book.fetch("id").to_i
      books.push(Book.new({:title => title,:id => id}))
    end
    books
  end
end
