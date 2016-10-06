class HistoricalQuery < ActiveRecord::Base
    validates :location, presence: true
    validates :remote_user, presence: true

    belongs_to :remote_user
    belongs_to :location, polymorphic: true

    paginates_per 10
end
