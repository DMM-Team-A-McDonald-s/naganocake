class OrderDetail < ApplicationRecord
  enum making_status: {
    unable_to_start: 0, # 着手不可(デフォルト)
    not_started: 1,    # 製作待ち
    in_production: 2,  # 製作中
    completed: 3       # 製作完了
  }

  belongs_to :order
  belongs_to :item
end
