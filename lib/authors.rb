class Author
  attr_reader :id
  attr_accessor :name, :book_id

  def initialize(attr)
    @name = attr.fetch(:name)
    @book_id = attr.fetch(:book_id)
    @id = attr.fetch(:id)
  end

  def == (author_to_compare)
    if author_to_compare != nil
      (self.name() == author_to_compare.name()) && (self.book_id() == author_to_compare.book_id())
    else
      false
    end
  end

  def self.all
    returned_authors = DB.exec("SELECT * FROM authors ORDER BY name;")
    authors = []
    returned_authors.each() do |author|
      name = author.fetch("name")
      book_id = author.fetch("book_id").to_i
      id = author.fetch("id").to_i
      authors.push(Author.new({:name => name,:book_id => book_id, :id => id}))
    end
    authors
  end

  def save
    result = DB.exec("INSERT INTO authors (name, book_id) VALUES ('#{@name}', #{@book_id}}) RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def self.find(id)
    result = DB.exec("SELECT * FROM authors WHERE id = #{id};").first
    if author
      name = author.fetch("name")
      book_id = author.fetch("book_id").to_i
      id = author.fetch("id").to_i
      Author.new({:name => name, :book_id => book_id, :id => id})
    else
      nil
    end
  end

  def update(name, book_id)
    @name = name
    @book_id = book_id
    DB.exec("UPDATE authors SET name = '#{@name}', book_id = #{@book_id} WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE * FROM authors WHERE id = #{id};")
  end

  def self.find_by_book(book_id)
    authors = []
    returned_authors = DB.exec("SELECT * FROM authors WHERE book_id = #{book_id};")
    returned_authors.each() do |author|
      title = author.fetch("title")
      id = author.fetch("id").to_i
      book_id = author.fetch("book_id").to_i
      authors.push(Song.new({:title => title, :book_id => book_id, :id => id}))
    end
    authors
  end

  def book
    Book.find(@book_id)
  end

end
