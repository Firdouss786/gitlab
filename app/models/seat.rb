class Seat < ApplicationRecord
  belongs_to :fleet

  validates :name, :col, :row, presence: true

  def self.first_deck
    where(deck: 1)
  end

  def self.second_deck
    where(deck: 2)
  end

  def self.number_of_rows
    maximum(:row) - minimum(:row) + 1
  end

  def self.offseted_row_start
    minimum(:row) - 1
  end

  def self.column_characters
    (minimum(:col)..maximum(:col)).to_a
  end
end
