require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe 'バリデーションテスト' do
    subject(:todo) { create(:todo) }

    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title) }
    it { is_expected.to define_enum_for(:status).with_values(todo: 0, doing: 1, done: 2) }
  end

  describe 'アソシエーションテスト' do
    subject(:todo) { create(:todo) }

    it { is_expected.to belong_to(:todo_list) }
  end
end
