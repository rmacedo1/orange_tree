require 'rspec'

RSpec.describe 'OrangeTree' do 
	describe '#height' do
		it 'returns a trees height' do
			#setup
			my_tree=OrangeTree.new

			#assertion
			expect(my_tree.height).to eq(1)
		end
	end

	describe '#one_year_passes' do
		it 'ages the tree one year' do
			#setup
			my_tree=OrangeTree.new
			my_tree.one_year_passes

			#assertion
			expect(my_tree.age).to eq(1)
		end

		it 'grows the tree by 1 ft' do
			#setup
			my_tree=OrangeTree.new
			my_tree.one_year_passes
			my_tree.one_year_passes

			#assertion
			expect(my_tree.height).to eq(3)
		end

		it 'makes the tree produce fruit at 10 years' do
			#setup
			my_tree=OrangeTree.new
			10.times do
				my_tree.one_year_passes
			end

			#assertion
			expect(my_tree.count_the_oranges).to eq(10)
		end

		it 'makes the tree produce 10 more oranges every 5 years after age 10' do
			#setup
			my_tree=OrangeTree.new
			20.times do
				my_tree.one_year_passes
			end

			#assertion
			expect(my_tree.count_the_oranges).to eq(30)
		end

		it 'removes all the oranges still on the tree' do
			#setup
			my_tree=OrangeTree.new
			13.times do
				my_tree.one_year_passes
			end

			#assertion
			expect(my_tree.count_the_oranges).to eq(10)
		end

		it 'kills the tree when it\'s 100 years old, so no more aging, growing or oranges' do
			#setup
			my_tree=OrangeTree.new
			101.times do
				my_tree.one_year_passes
			end

			#assertion
			expect(my_tree.is_dead).to eq(true)
			expect(my_tree.age).to eq(100)
			expect(my_tree.height).to eq(101)
			expect(my_tree.pick_an_orange).to eq('Sorry! There are no oranges.')
		end
	end

	describe '#count_the_oranges' do
		it 'returns the number of oranges on the tree' do
			#setup
			my_tree=OrangeTree.new

			#assertion
			expect(my_tree.count_the_oranges).to eq(0)
		end
	end

	describe '#pick_an_orange' do
		it 'decreases the number of oranges by 1 and returns a string saying it was delicious' do
			#setup
			my_tree=OrangeTree.new
			11.times do
				my_tree.one_year_passes
			end

			#assertion
			expect(my_tree.pick_an_orange).to eq('What a delicious orange!')
		end

		it 'returns a string saying there are no oranges when that\'s the case' do
			#setup
			my_tree=OrangeTree.new
			10.times do
				my_tree.one_year_passes
			end

			10.times do
				my_tree.pick_an_orange
			end

			#assertion
			expect(my_tree.pick_an_orange).to eq('Sorry! There are no oranges.')
		end
	end
end

class OrangeTree 
	def initialize
		@height = 1
		@age = 0
		@num_oranges = 0
		@is_dead = false
	end

	def height
		@height
	end

	def age
		@age
	end

	def is_dead
		@is_dead
	end

	def count_the_oranges
		@num_oranges
	end

	def pick_an_orange
		response=''

		if @num_oranges==0
			response='Sorry! There are no oranges.'
		else
			@num_oranges-=1
			response='What a delicious orange!'
		end

		response
	end

	def one_year_passes
		#age the tree and grow by 1 ft
		if !@is_dead
			@age+=1
			@height+=1
		end

		#increment orange production as tree ages
		if @age>=10 && @age%5==0 && !@is_dead
			@num_oranges=10+10*(@age/5 -2)
		end

		#at age 100 the tree dies
		if @age==100
			@is_dead=true
			@num_oranges=0
		end
	end
end