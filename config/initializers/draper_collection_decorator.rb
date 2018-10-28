class Draper::CollectionDecorator
  delegate :current_page, :limit_value, :num_pages, :reorder, :total_count,
           :total_pages
end
