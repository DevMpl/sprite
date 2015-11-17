class Sprite::City < ActiveRecord::Base

  belongs_to :prefecture
  default_scope { order(id: :asc, sequence: :asc) }

  scope :region, -> (region_slugs = nil) do
    region_ids = region_slugs.present? ? Region.where(slug: region_slugs).map(&:id) : []
    includes(area: {prefecture: :region}).where.not(area_id: 0).where({areas: {prefecture_id: Prefecture.where(region_id: region_ids).map(&:id)}})
  end

end