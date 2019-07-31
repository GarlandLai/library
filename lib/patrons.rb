class Patron
attr_reader :id,:name

  def initialize(attr)
    @name = attr.fetch(:name)
    @id = attr.fetch(:id)
  end

end
