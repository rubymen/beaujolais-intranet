require 'rspec/autorun'

describe User do
  subject(:user) { FactoryGirl.create(:user, firstname: 'admin', lastname: 'nimda') }

  before :all do
    DatabaseCleaner.clean
  end

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:firstname) }
  it { should validate_presence_of(:lastname) }
  it { should validate_presence_of(:type) }

  it { should validate_uniqueness_of(:email) }
end
