require "test_helper"

describe User do
  describe 'relations' do
    it 'can have many votes' do
      #use fixtures yml data
      user = users(:user0)

      expect(user.votes.size).must_equal 4
    end

    it 'can access works through votes' do
      user = users(:user0)

      expect(user.works.count).must_equal 4
    end

  end

  describe 'validations' do
    before do
      # Arrange a valid user
      @user = User.new(username: 'Username')
    end

    it 'is valid when all fields are present' do
      # Act
      result = @user.valid?

      # Assert
      expect(result).must_equal true
    end

    it 'is invalid without username' do
      @user.username = nil
      result = @user.valid?

      expect(result).must_equal false
    end
  end

end
