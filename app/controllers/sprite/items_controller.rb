class Sprite::ItemsController < Sprite::ApplicationController

  # cache_sweeper :item_sweeper, :only => [ :edit, :destroy ]

  before_action :set_item, only: [:show, :edit, :update, :destroy, :clear_page_cache, :preview]

  def index
    @q = Sprite::Item.search(params[:q])
    @items = @q.result.page(params[:page]).per(20)
  end

  def show
  end

  def new
    @item = Sprite::Item.new
    @item.build_item_location
  end

  def edit
    @item.build_item_location unless @item.item_location
  end

  def create
    @item = Sprite::Item.new(item_params)
    if @item.save
      redirect_to items_path, notice: '記事の登録が完了しました'
    else
     @item.build_item_location
     render :new
    end
  end

  def positions
    without_ids = []
    if params[:title_cont].present?
      @searched = Sprite::Item.includes(:item_position).where(item_positions: {id: nil}).search(title_cont: params[:title_cont]).result
      without_ids = @searched.pluck(:id)
    end

    @items = Sprite::Item.on_the_top(false, without_ids)

  end

  def update_positions
    ItemPosition.sort!(params[:positions])
    redirect_to item_positions_path, notice: '記事の順番変更が完了しました'
  end

  def update
    if @item.update(item_params)
      redirect_to items_path, notice: '記事の修正が完了しました'
    else
     @item.build_item_location
     render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to :back, notice: '記事の削除が完了しました'
  end

  def clear_page_cache
    @item.clear_page_cache
    redirect_to :back, notice: '記事のページキャッシュをクリアしました'
  end

  def tags
    @tags = Item.tag_counts_on(:tags).order('count DESC')
  end

  def tag
    return if root_path unless params[:tag]
    @items = Sprite::Item.active.tagged_with(params[:tag])
  end

  def change_data
    Sprite::Item.change_data(params[:items])
    return redirect_to :back, flash: {notice: 'データを変更しました'}
  end

  def preview
    render 'items/show', layout: 'application'
  end

  def truncate
    Sprite::Content.friendly.find(params[:id]).items.destroy_all
    redirect_to :back, flash: {notice: '記事を全て削除しました'}
  end

  private
    def set_item
      @item = Sprite::Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:title, :content_id, :categories, :url, :description, :body, :pr_flg, :pr_url, :pr_title, :address, :lat, :lng, :pub_date, :mod_date, :exp_date, :status, item_location_attributes: [:city_id, :address, :lat, :lng], content_ids: [])
    end

end
