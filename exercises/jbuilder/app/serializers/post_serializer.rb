# frozen_string_literal: true

class PostSerializer < ActiveModel::Serializer
  attributes :id, :title

  belongs_to :user
end
