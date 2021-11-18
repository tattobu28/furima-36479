class Address < ApplicationRecord
  belongs_to :cart
  has_one :prefecture
end
