class Author
  attr_reader :id
  attr_accessor :name
  @@attr = []
  def initialize(attr)
    @name = attr.fetch(:name)
    @id = attr.fetch(:id)
  end


def save
  result = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}'}) RETURNING id;")
  @id = result.first().fetch("id").to_i
end

  def self.all
    returned_authors = DB.exec("SELECT * FROM authors ORDER BY name;")
    authors = []
    returned_authors.each() do |author|
      name = author.fetch("name")
      id = author.fetch("id").to_i
      authors.push(Author.new({:name => name,:id => id}))
    end
    authors
  end
end
