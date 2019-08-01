require('sinatra')
require('sinatra/reloader')
also_reload("./lib/**/*.rb")
require('pry')
require('pg')
require('./lib/patrons')
require('./lib/books')

# this connects to postgres and captures the connection in a constant
DB = PG.connect({:dbname => "library"})

get ('/') do
  erb(:index)
end

get ('/books') do
  @books = Book.all
  erb(:books)
end

get ('/books/new') do
  erb(:new_book)
end

post ('/books') do
  title = params[:book_title]
  book = Book.new({:title => title, :id => nil})
  book.save()
  redirect to ('/books')
end

get ('/books/:id') do
  @book = Book.find(params[:id].to_i())
  erb(:book)
end

# get ('/book_author') do
#   erb(:book_author)
# end
#
# post ('/book') do
#   title = params[:title]
#   book = Book.new(:title => title, :id => nil)
#   book.save()
#   @books = Book.all()
#   erb(:book_author)
# end
#
# post ('/book_author') do
#   name = params[:name]
#   author = Author.new(author)
#   author.save()
#   @authors = Author.all()
#   erb(:index)
# end


# get ('/patron') do
#   erb(:patron_search)
# end
#
# post ('/patron_search') do
#   name = params[:name]
#   @results = DB.exec("SELECT * FROM patrons;")
#   id = DB.exec("SELECT id FROM patrons WHERE name=#{'name'};")
#   binding.pry
#   @results[:id]
#   erb(:patron)
# end
