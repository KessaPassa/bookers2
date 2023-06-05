# frozen_string_literal: true

# :nocov:
class Search < ActiveHash::Base
  self.data = [
    { id: 1, name: '完全一致' },
    { id: 2, name: '前方一致' },
    { id: 3, name: '後方一致' },
    { id: 4, name: '部分一致' }
  ]
end
# :nocov:
