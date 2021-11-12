class Address < ApplicationRecord
  belongs_to :cart
  belongs_to :prefecture
end
