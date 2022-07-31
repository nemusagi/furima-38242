class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string     :name,                null: false
      t.text       :content,             null: false
      t.integer    :category_id,         null: false
      t.integer    :status_id,           null: false
      t.integer    :shipping_charge_id,  null: false
      t.integer    :shippers_area_id,    null: false
      t.integer    :shipment_date_id,    null: false
      t.integer    :price,               null: false
      t.references :user,                null: false, foreign_key: true
      t.timestamps
    end
  end
end
