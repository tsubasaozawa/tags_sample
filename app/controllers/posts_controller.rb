class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.includes(:categories) # トップページでもタグ表示ができるようincludes(:categories)を設定
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @category_list = @post.categories.pluck(:tag_name).join(",") # 配列に入っている情報（postに紐づくタグ情報）の中からpluck(:tag_name)でタグ情報だけ取得
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    category_list = params[:category_list].split(",") # paramsに含まれているタグ情報を変数に代入

    respond_to do |format|
      if @post.save
        @post.save_categories(category_list) # タグ情報をテーブルに保存
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    category_list = params[:category_list].split(",") # paramsに含まれているタグ情報を変数に代入
    respond_to do |format|
      if @post.update(post_params)
        @post.save_categories(category_list) # 編集したタグ情報をテーブルに保存
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :category_list) # ストロングパラメータに:category_listを追加
    end
end
