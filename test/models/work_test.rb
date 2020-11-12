require 'test_helper'

describe Work do
  describe 'relations' do
    describe 'votes relations' do
      it 'accepts votes' do
        user = User.create!(username: "Test user")
        work = Work.create!(category: 'movie', title: 'Test movie')
        vote = Vote.create!(user: user, work: work)


        expect(work.votes.include?(vote)).must_equal true
        expect(work.votes.size).must_equal 1
      end

    end
  end

  describe 'validation' do
    before do
      #Arrange: a valid work
      @work = Work.new(category: 'book', title: 'title', publication: 1992, description: 'long description')
    end

    it 'is valid when all fields are present' do
      # Another way to write this:
      #value(@work).must_be :valid?

      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal true
    end

    it 'is valid without optional fields (publication and description)' do
      @work.publication = nil
      @work.description = nil
      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal true
    end

    it 'is invalid without category' do
      @work.category = nil

      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :category
    end

    it 'is invalid without title' do
      @work.title = nil

      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :title
    end
  end

end
