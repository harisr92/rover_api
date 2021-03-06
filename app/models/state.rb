class State < ApplicationRecord
  belongs_to :platue, dependent: :destroy
  validates :x, :y, :face, presence: true
  validates :x, :y, numericality: { greater_than_or_equal_to: 0 }

  before_save :validate_pos

  def state_change
    { 'N' => { y: y + 1 }, 'S' => { y: y - 1 }, 'E' => { x: x + 1 },
      'W' => { x: x - 1 } }
  end

  private

  def validate_pos
    self.class.validates :x,
                         numericality: { less_than_or_equal_to: platue.width }
    self.class.validates :y,
                         numericality: { less_than_or_equal_to: platue.height }
  end
end
