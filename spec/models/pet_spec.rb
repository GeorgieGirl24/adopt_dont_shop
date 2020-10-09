require 'rails_helper'

describe Pet do
  it { should belong_to :shelter}
end
