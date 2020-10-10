require 'rails_helper'

describe Pet do
  it { should belong_to :shelter }
end

describe Pet do
  it { should validate_presence_of :shelter_id }
end
