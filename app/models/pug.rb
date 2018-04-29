class Pug < ApplicationRecord
  PUG_TYPES = %w(
    tryhard
    mixed
    eu
  )

  has_many :pug_members


  validates :pug_type, inclusion: { in: PUG_TYPES }
end
