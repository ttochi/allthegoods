class GroupsController < ApplicationController
    before_action :authenticate_admin!, except: [:index, :show]
    before_action :set_group, only: [:show, :edit, :update, :destroy]

    # GET /groups
    def index
        @groups = Group.all
    end

    # GET /groups/1
    def show
        @members = @group.members

        @items = Item.joins('LEFT JOIN corresponds ON corresponds.item_id = items.id')
                       .joins('LEFT JOIN members ON corresponds.member_id = members.id')
                       .where('members.group_id = ?', @group.id)
                       .group('items.id')

        if params[:member].present?
            @items = @items.where('members.id = ?', params[:member])
            @member = @members.find(params[:member])
        end

        case params[:order]
            when 'deadline'
                @items = @items.where('due_date >= ?', Time.now.to_date).order(due_date: :asc)
            when 'popular'
                @items = @items.order(view_count: :desc)
            else
                @items = @items.order(id: :desc)
        end
    end

    # GET /groups/new
    def new
        @group = Group.new
        @group.members.build
    end

    # GET /groups/1/edit
    def edit
    end

    # POST /groups
    def create
        @group = Group.new(group_params)

        respond_to do |format|
            if @group.save
                format.html { redirect_to @group, notice: '그룹을 생성하였습니다.' }
                format.json { render :show, status: :created, location: @group }
            else
                format.html { render :new }
                format.json { render json: @group.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /groups/1
    def update
        respond_to do |format|
            if @group.update(group_params)
                format.html { redirect_to @group, notice: '그룹을 수정하였습니다.' }
                format.json { render :show, status: :ok, location: @group }
            else
                format.html { render :edit }
                format.json { render json: @group.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /groups/1
    def destroy
        @group.destroy
        respond_to do |format|
            format.html { redirect_to groups_url, notice: '그룹을 삭제하였습니다.' }
            format.json { head :no_content }
        end
    end

    private
    def set_group
        @group = Group.find(params[:id])
    end

    def group_params
        params.require(:group).permit(:name, :img, members_attributes: [:name, :id, :_destroy])
    end
end
