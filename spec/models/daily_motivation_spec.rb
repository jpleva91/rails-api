require 'rails_helper'

RSpec.describe DailyMotivation, type: :model do
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:quote) }
  it { should validate_presence_of(:author) }
end
