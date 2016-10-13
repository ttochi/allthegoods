class ItemsController < ApplicationController
    before_action :authenticate_admin!, except: [:index]
    before_action :set_item, only: [:show, :edit, :update, :destroy]

    def index
        params[:state] ||= '0'
        params[:month] ||= Date.today.beginning_of_month

        @groups = Group.all

        @items = Item.all.where('due_date >= ?', Date.today)

        if params[:group].present?
            @items = @items.joins('LEFT JOIN corresponds ON corresponds.item_id = items.id')
                           .joins('LEFT JOIN members ON corresponds.member_id = members.id')
                           .where('members.group_id = ?', params[:group])
                           .group('items.id')
        end

        if params[:state] == '0'
            @items = @items.where('state = 0')
        else
            @items = @items.where('state = 1 or state = 2')
        end

        @items = @items.where('due_date >= ? and due_date < ?', params[:month].to_date, params[:month].to_date.next_month).order(due_date: :asc)

    end

    def show
        require 'nokogiri'
        require 'open-uri'

        if @item.artist_url.present?
            art_url = "https://twitter.com/" + @item.artist_url
            art_doc = Nokogiri::HTML(doc = open(art_url))
            @artist_name = art_doc.css("a.ProfileHeaderCard-nameLink")[0].content
            @artist_img = art_doc.css("img.ProfileAvatar-image")[0]['src']
        end
        if @item.seller_url.present?
            sell_url = "https://twitter.com/" + @item.seller_url
            sell_doc = Nokogiri::HTML(doc = open(sell_url))
            @seller_name = sell_doc.css("a.ProfileHeaderCard-nameLink")[0].content
            @seller_img = sell_doc.css("img.ProfileAvatar-image")[0]['src']
        end

        @detail_img = [@item.img_1, @item.img_2, @item.img_3, @item.img_4, @item.img_5]

        @item.update(view_count: @item.view_count + 1)
    end

    def new
        @item = Item.new
    end

    def edit
    end

    def create
        @item = Item.new(item_params)

        respond_to do |format|
            if @item.save
                format.html { redirect_to @item, notice: '굿즈를 생성하였습니다.' }
                format.json { render :show, status: :created, location: @item }
            else
                format.html { render :new }
                format.json { render json: @item.errors, status: :unprocessable_entity }
            end
        end
    end

    def update
        respond_to do |format|
            if @item.update(item_params)
                format.html { redirect_to @item, notice: '굿즈를 수정하였습니다.' }
                format.json { render :show, status: :ok, location: @item }
            else
                format.html { render :edit }
                format.json { render json: @item.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @item.destroy
        respond_to do |format|
            format.html { redirect_to :back, notice: '굿즈를 삭제하였습니다.' }
        end
    end

    private
    def set_item
        @item = Item.find(params[:id])
    end

    def item_params
        params.require(:item).permit(Item.attribute_names + [:member_ids => []])
    end
end