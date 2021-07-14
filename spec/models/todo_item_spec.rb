require 'rails_helper'

RSpec.describe TodoItem, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to embed_many :tags }

  it { is_expected.to have_field(:title).of_type(String) }
  it { is_expected.to have_field(:status).of_type(String) }
  it { is_expected.to have_field(:deleted_at).of_type(DateTime) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_uniqueness_of(:title) }

  it { is_expected.to accept_nested_attributes_for(:tags) }
end