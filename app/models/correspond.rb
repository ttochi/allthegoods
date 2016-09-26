class Correspond < ActiveRecord::Base
    belongs_to :item
    belongs_to :member

    after_destroy :destroy_blank_item

    def destroy_blank_item
        other_relation = Correspond.where(item_id = self.item.id)
        if other_relation.length == 0
            self.item.destroy
        end
    end
end