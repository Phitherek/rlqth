class RemoteUser < ActiveRecord::Base
    validates :callsign, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true

    has_many :remote_sessions
    has_many :historical_queries
end
