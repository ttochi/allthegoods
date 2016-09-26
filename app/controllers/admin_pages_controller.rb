class AdminPagesController < ApplicationController
    before_action :authenticate_admin!

    def index
        @items = Item.all

        @items = @items.where('name LIKE ?', '%' + params[:query] + '%') unless params[:query].blank?
        @items = @items.order(due_date: :asc) unless params[:order].blank?
    end
end