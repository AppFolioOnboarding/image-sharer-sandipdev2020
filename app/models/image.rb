class Image < ApplicationRecord
  validates :url,
            presence: true,
            format: {
              with: %r{\A(http|https).*\.(png|jpg|jpeg|gif|svg)\z},
              message: 'invalid image url'
            }
end

