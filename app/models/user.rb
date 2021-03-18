# frozen_string_literal: true

class User < ApplicationRecord
  include Clearance::User
  has_one :match, dependent: :destroy
end
