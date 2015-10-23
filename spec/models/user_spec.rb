require 'rails_helper'
require 'spec_helper'

describe User do

  describe '#username' do
    context 'definindo um contexto' do
      # before do
      #   @user = User.new(username: 'ivoneijr')
      # end

      # let(:user) do # @user lazy loaded,
      #   User.new(username: 'ivoneijr')
      # end

      let!(:user) do # Using FactoryGirl
        create(:user)
      end

      it 'show username' do
        expect(user.username).to eq('ivoneijr')
      end

      it 'user nil' do
        # expect(user.email).to be_nil
      end
    end
  end

end
