class Sprite::ItemCategoriesController < Sprite::ApplicationController
  before_action :set_item_category, only: [:show, :edit, :update, :destroy, :move_lower, :move_higher]

  def index
    @item_categories = Sprite::ItemCategory.all
  end

  def show
  end

  def new
    @item_category = Sprite::ItemCategory.new
  end

  def edit
  end

  def create
    @item_category = Sprite::ItemCategory.new(item_category_params)
    if @item_category.save
      redirect_to item_categories_path, notice: 'カテゴリの登録が完了しました'
    else
      render :new
    end
  end

  def update
    if @item_category.update(item_category_params)
      redirect_to edit_item_category_path(@item_category), notice: 'カテゴリの修正が完了しました'
    else
      render :edit
    end
  end

  def destroy
    @item_category.destroy
  end

  def move_higher
    @item_category.move_higher
    redirect_to item_categories_path, notice: "カテゴリ「 #{@item_category.name}」の優先順位を変更しました"
  end

  # GET /categories/:slug/move_lower
  def move_lower
    @item_category.move_lower
    redirect_to item_categories_path, notice: "カテゴリ「 #{@item_category.name}」の優先順位を変更しました"
  end

  private
    def set_item_category
      @item_category = Sprite::ItemCategory.friendly.find(params[:id])
    end

    def item_category_params
      params.require(:item_category).permit(:id, :name, :slug, :note, :ancestry, :parent_id, :ancestry_depth, :position, :status)
    end

end
