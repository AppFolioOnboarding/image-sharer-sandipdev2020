class Image < ApplicationRecord
  acts_as_taggable_on :tags
  validates :url,
            presence: true,
            format: {
              with: %r{\A(http|https).*\.(png|jpg|jpeg|gif|svg)\z},
              message: 'invalid image url'
            }
end

