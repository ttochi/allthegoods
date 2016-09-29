class CreateItems < ActiveRecord::Migration
    def change
        create_table :items do |t|
            t.string :name
            t.string :kind
            t.integer :price
            t.integer :state
            t.datetime :due_date
            t.string :seller_url
            t.string :artist_url
            t.string :form_url
            t.string :description
            t.string :img_main
            t.string :img_1
            t.string :img_2
            t.string :img_3
            t.string :img_4
            t.string :img_5
            t.integer :view_count, null: false, default: 0
            t.boolean :on_hide

            t.timestamps null: false
        end
    end
end
