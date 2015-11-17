class Sprite::Item < ActiveRecord::Base

  TOP_LIMIT = 50

  has_one :item_position, dependent: :destroy

  has_many :item_item_categories, dependent: :destroy, foreign_key: 'item_id'
  has_many :contents, through: :item_item_categories, class_name: 'ItemCategory'
  accepts_nested_attributes_for :item_item_categories, allow_destroy: true

  has_one :item_location, dependent: :destroy
  accepts_nested_attributes_for :item_location, reject_if: :all_blank

  acts_as_taggable

  validates :title, presence: true
  # validates :category_id
  # validates :categories
  # validates :url, presence: true
  # validates :description, presence: true
  # validates :body, presence: true
  # validates :address, presence: true
  # validates :lat, presence: true
  # validates :lng, presence: true
  validates :status, presence: true

  # has_many :images, class_name: 'Image::Item', as: :parent, dependent: :destroy

  # has_many :item_images, dependent: :destroy

  scope :active, -> { where(status: 'public') }
  scope :get_url, -> (url) { where(url: url) }
  scope :only_outside, -> { where.not(contents: {slug: [:nnp_news, :nnp_nlp, :fanfunfukuoka]}) }

  default_scope { order(pub_date: :desc, id: :desc) }

  def self.remember_fav_categories(fav, to_be_fav)

    if fav.present?
      if new = to_be_fav - fav.split(",")
        if new.present?
          fav = (fav.split(",") + new).reverse[0, REMEMBER_CATEGORY_LIMIT].reverse.join(",")
        end
      end
    else
      fav = to_be_fav.to_a.join(",")
    end
    fav

  end

  def build_images
    self.images.size.times { self.images.build }
  end

  def change_to_mod_date?(record)
    if record.mod_date.present?
      self.mod_date.to_i != DateTime.parse(record.mod_date.to_s).to_i
    else
      return false
    end
  end

  def self.on_the_top(only_active = true, without_ids = [])

    positioned = self.positioned(only_active)
    position_list = positioned.inject({}){|m, e| m[e.item_position.sequence] = e; m }
    items = Sprite::Item.active.includes(:content, :item_images).where.not(id: positioned.map(&:id) + without_ids).limit(self::TOP_LIMIT - positioned.count).order("pub_date DESC")

    items = items.active if only_active
    items = items.to_a

    self::ADMIN_TOP_LIMIT.times do |t|
      if position_list[t - 1].present?
        items[t - 2, 0] = position_list[t - 1]
      end
    end

    items

  end

  def self.positioned(only_active = true)
    item = Sprite::Item.includes(:item_position).where.not(item_positions: {id: nil}).order("item_positions.sequence DESC")
    only_active ? item.active : item
  end

  # def self.on_the_top(only_active = true, without_ids = [])

  #   positioned = self.positioned(only_active)
  #   position_list = positioned.inject({}){|m, e| m[e.item_position.sequence] = e; m }

  #   order = Content.active.pluck(:id).shuffle.join(",")
  #   items = Item.group(:content_id).reorder("FIELD(content_id, #{order})")

  #   items = items.active if only_active
  #   items = items.to_a

  #   self::TOP_LIMIT.times do |t|
  #     if position_list[t - 1].present?
  #       items[t - 2, 0] = position_list[t - 1]
  #     end
  #   end

  #   items

  # end

  def self.change_data(params)
    return if params.blank?

    params.each do |id, attrs|
      item = Sprite::Item.find(id)
      begin
        item.update(attrs.permit(:status, content_ids: []))
      rescue Exception
        return false
      end

    end

    return true

  end

  def change_status(status = '')
    return if status.blank?
    self.update_attribute(:status, status)
  end

  def main_images
    Sprite::ItemImage.get_set_images.where(item_id: self).all
  end

  def main_image
    return [] if item_images.empty?
    set_images = item_images.select{|i| i.set_image == 1 }

    images = set_images.present? ? set_images : item_images
    images.sort{|a, b| a.sequence <=> b.sequence }.first
  end

  def self.publishes(slug)
    begin
      service = Service.where(slug: slug).first
      includes({content: :content_services}, :item_services).where(content_services: {service_id: service.id}).where(item_services: {service_id: service.id})
    rescue Exception
    end

  end

  def self.latest(conditions = [], limit = nil)
    items = where(conditions)
    if limit.present?
      items.limit(limit)
    else
      items
    end
  end

  def self.top_ranked(limit = 1)

    path = "/var/www/nnp_curation/ranking_batch/ranking.csv"
    return [] unless File.exist?(path)

    require 'csv'

    items = []
    CSV.foreach(path) do |row|
      begin
        item_id = row.first.split('/').last.to_i
        items << Item.find(item_id)
      rescue Exception
      end

      break if items.count == limit

    end

    items

  end

  def clear_page_cache
    PageCache.clear(File.join(content.slug, 'article', "#{id}.html"))
  end


  # validate :any_images?

  # def any_images?
  #   self.errors.add(:any_images, "最低1枚画像をアップロードしてください") if images.empty?
  # end

  # def self.all_categories
  #   self.select(:categories).map{|i| i.categories.gsub(/　/, ' ').split(' ') }.flatten.uniq
  # end

end