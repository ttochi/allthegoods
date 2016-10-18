class ChangeImageOnGroups < ActiveRecord::Migration
    def change
        remove_column :groups, :img
        add_attachment :groups, :image
    end
end
