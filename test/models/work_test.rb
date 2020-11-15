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

      it 'has many votes' do
        #use fixtures yml data
        work = works(:album4)

        expect(work.votes.count).must_equal 6
      end

      it 'can access users through votes' do
        work = works(:album4)

        expect(work.users.count).must_equal 6

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

  describe 'top_work_method' do
    it 'returns the top work' do
      # Arrange / Act
      # trying to use the fixtures
      spotlight = Work.top_work
      most_votes = works(:album4)


      expect(spotlight.id).must_equal most_votes.id
    end

    it 'return nil if no works' do
      Work.all.each do |work|
        work.destroy
      end

      featured_work = Work.top_work

      expect(featured_work).must_be_nil
    end
  end

  describe 'top_ten method' do
    it 'gets top ten for more than 10 items' do
      skip
    end

    it 'gets top ten for less than 10 items' do
      skip
    end

    it 'returns nil for no top ten of empty category' do
      skip
    end

  end

end
