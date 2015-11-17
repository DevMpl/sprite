class Sprite::Page < Sprite::Content

  include PositionRebuild

  extend FriendlyId
  friendly_id :slug, use: :slugged

  validates :name, presence: true
  validates :slug, presence: true #, slug: true
  # validates :note, presence: true
  validates :status, presence: true
	validates :slug, uniqueness: { scope: :type }
	
  has_many :items

  scope :active, -> { where(status: 'public') }
  scope :parented, -> (parent) { where(parented_id: parent) }
  scope :ascending, -> { order(position: :asc) }

  before_save :save_parented_id

  has_ancestry cache_depth: true, orphan_strategy: :adopt

  scope :ordered, -> {order(ancestry_depth: :desc, position: :asc) }
	
  def deletable?
  	# TEMP
  	true
    # ! PageContent.includes(:contents).exists?(contents: {id: id, type: 'Page'})
  end

  def self.children_flatten(root_obj = nil)
    children_list = []
    categories = root_obj.nil? ? self.roots : [[root_obj]]
    categories.each do |category|
      children_list << category
      children_list << self.arrange_array_flatten(category.descendants.arrange(order: :position))
    end
    children_list.flatten
  end

  def self.arrange_array_flatten(categories)
    datas = []
    categories.each do |category, children|
      datas << category
      if children.present?
        datas << arrange_array_flatten(children)
      end
    end
    datas.flatten
  end

  def save_parented_id
    self.parented_id = self.parent_id
  end

end
