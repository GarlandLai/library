class Book
  attr_reader :id
  attr_accessor :title
  @@attr = []

  def initialize(attr)
    @title = attr.fetch(:title)
    @id = attr.fetch(:id)
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

  def save
    result = DB.exec("INSERT INTO books (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def update(title)
    @title = title
    DB.exec("UPDATE books SET title = '#{title}' WHERE id = '#{@id}'")
  end

  def delete
    DB.exec("DELETE FROM Books WHERE id = #{@id};")
    # DB.exec("DELETE FROM Authors WHERE book_id = #{@id};")
  end

  def authors
    Author.find_by_book(self.id)
  end

  def self.find(id)
    book = DB.exec("SELECT * FROM books WHERE id = #{id};").first
    title = book.fetch("title")
    id = book.fetch("id").to_i
    Book.new({:title => title, :id => id})
  end

  def self.clear
    DB.exec("DELETE FROM Books *;")
  end

end
