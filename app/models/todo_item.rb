class TodoItem
  include Mongoid::Document
  include Mongoid::Paranoia

  TYPE_OF_STATUS = ['start', 'finish', 'not start'].freeze

  field :title, type: String
  field :status, type: String
  field :deleted_at, type: DateTime

  validates_presence_of :title, :status
  validates_uniqueness_of :title
  validate :validate_status

  embeds_many :tags
  accepts_nested_attributes_for :tags

  default_scope -> { where(deleted_at: nil) }

  private

  def validate_status
    errors.add(:status, 'Status can be start, finish or not start') unless TYPE_OF_STATUS.include?(status)
  end
end
