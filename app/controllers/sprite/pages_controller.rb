class Sprite::PagesController < Sprite::ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy, :move_lower, :move_higher]

  def index
    @pages = Sprite::Page.all
  end

  def show
  end

  def new
    @page = Sprite::Page.new
  end

  def edit
  end

  def create
    @page = Sprite::Page.new(page_params)
    @page.type = 'Sprite::Page'
    if @page.save
      redirect_to pages_path, notice: 'カテゴリの登録が完了しました'
    else
      render :new
    end
  end

  def update
    if @page.update(page_params)
      redirect_to edit_page_path(@page), notice: 'カテゴリの修正が完了しました'
    else
      render :edit
    end
  end

  def destroy
    @page.destroy
  end

  def move_higher
    @page.move_higher
    redirect_to pages_path, notice: "カテゴリ「 #{@page.name}」の優先順位を変更しました"
  end

  # GET /pages/:slug/move_lower
  def move_lower
    @page.move_lower
    redirect_to pages_path, notice: "カテゴリ「 #{@page.name}」の優先順位を変更しました"
  end

  private
    def set_page
      @page = Sprite::Page.friendly.find(params[:id])
    end

    def page_params
      params.require(:page).permit(:id, :name, :slug, :note, :ancestry, :parent_id, :ancestry_depth, :position, :is_directory, :status)
    end

end
