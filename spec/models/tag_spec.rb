require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to be_embedded_in :todo_item }

  it { is_expected.to have_field(:content).of_type(String) }

  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_uniqueness_of(:content) }
end
