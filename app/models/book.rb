class Book < ActiveRecord::Base
  # enum status: %w{reservation now_on_sale end_of_print}
  enum status: {reservation: 0, now_on_sale: 1, end_of_print: 2}

	scope :costly, -> {where("price > ?", 3000)}
	scope :written_about, ->(theme) {where("name like ?", "%#{theme}%")}

	belongs_to :publisher
	
	has_many :book_authors
	has_many :authors, through: :book_authors

	validates :name, presence: true
	validates :name, length: { maximum: 15 }
	validates :price, numericality: { greater_than_or_equal_to: 0 }
	validate do |book|
		if book.name.include?("exercise") then
			book.errors[:name] << "I don't like exercise."
		end
	end
	before_validation do |book|
		book.name = self.name.gsub(/Cat/) { |matched| "lovely #{matched}" }
	end

	after_destroy {|book| Rails.logger.info("Book is deleted: #{book.attributes.inspect}") }

	def high_price?
		price >= 5000
	end

	after_destroy :if => :high_price? do |book|
		Rails.logger.warn "Book with high price is deleted: #{book.attributes.inspect}"
		Rails.logger.warn "Please Check!!"
	end
end
