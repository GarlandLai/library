require 'rspec'
require 'books'
require 'authors'
require 'pry'
require 'spec_helper'

# describe '#Book' do

#   before(:each) do
#     Book.clear
#     Author.clear
#   end
#
  describe('.all') do
    it("returns an empty array when there are no books") do
      expect(Book.all).to(eq([]))
    end
  end
#
  describe('#save') do
    it("saves an book") do
      book = Book.new({:title => "A Love Supreme", :id => nil})
      book.save()
      book2 = Book.new({:title => "Blue", :id => nil})
      book2.save()
      expect(Book.all).to(eq([book, book2]))
    end
  end
#
  describe('.clear') do
    it("clears all books") do
      book = Book.new({:title => "A Love Supreme", :id => nil})
      book.save()
      book2 = Book.new({:title => "Blue", :id => nil})
      book2.save()
      Book.clear
      expect(Book.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same book if it has the same attributes as another book") do
      book = Book.new({:title => "Blue", :id => nil})
      book2 = Book.new({:title => "Blue", :id => nil})
      expect(book).to(eq(book2))
    end
  end
#
  describe('.find') do
    it("finds an book by id") do
      book = Book.new({:title => "A Love Supreme", :id => nil})
      book.save()
      book2 = Book.new({:title => "Blue", :id => nil})
      book2.save()
      expect(Book.find(book.id)).to(eq(book))
    end
  end
#
  describe('#update') do
    it("updates an book by id") do
      book = Book.new({:title => "A Love Supreme", :id => nil})
      book.save()
      book.update("A Love Supreme")
      expect(book.title).to(eq("A Love Supreme"))
    end
  end
#
  describe('#delete') do
    it("deletes an book by id") do
      book = Book.new({:title => "A Love Supreme", :id => nil})
      book.save()
      book2 = Book.new({:title => "Blue", :id => nil})
      book2.save()
      book.delete()
      expect(Book.all).to(eq([book2]))
    end
  end

  describe('#authors') do
    it("returns an book's authors") do
      book = Book.new({:title => "A Love Supreme", :id => nil})
      book.save()
      author = Author.new({:name => "Naima", :book_id => book.id, :id => nil})
      author.save()
      author2 = Author.new({:name => "Cousin Mary", :book_id => book.id, :id => nil})
      author2.save()
      expect(book.authors).to(eq([author, author2]))
    end
  end
# end
