class PugMember < ApplicationRecord
  belongs_to :pug

  def pug_ping
    "#{ping_string} - #{battlenet}"
  end
end
