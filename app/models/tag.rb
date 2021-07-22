class Tag
  include Mongoid::Document
  field :content, type: String

  embedded_in :todo_item

  validates :content, presence: true, uniqueness: true
end
