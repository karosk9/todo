require 'dry-types'

module Types
  include Dry.Types()

  Index = String.constrained(format: /[a-z]+-[1-9]+/i)
end

class Project < Dry::Struct
  attribute :index_number, Types::Index
  attribute :title, Types::Strict::String
  attribute :description, Types::Strict::String.optional
  attribute :summary, Types::Strict::String
  attribute :estimated_cost, Types::Coercible::Float.optional.meta(info: 'USD')
  attribute :labels, Types::Array.of(Types::Coercible::String).optional
  attribute :start_date, Types::Date.default { Date.today }
  attribute :end_date, Types::Date.constrained(gteq: Date.today)
  attribute :executor_name, Types::Strict::String
  attribute :reporter_name, Types::Strict::String.optional
end
