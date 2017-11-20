class Topup < ApplicationRecord
  monetize :price_cents
end
