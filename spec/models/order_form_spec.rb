require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_form = FactoryBot.build(:order_form, user_id: user.id, item_id: item.id)
    end
    context '商品が購入できる場合' do
      it 'すべての項目が存在していれば購入できる' do
        expect(@order_form).to be_valid
      end
      it 'buildingは空でも保存できる' do
        @order_form.building = ''
        expect(@order_form).to be_valid
      end
    end
    context '商品が購入できない場合' do
      it 'postal_codeが空では購入できない' do
        @order_form.postal_code =''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'prefecture_idを選択しないと購入できない' do
        @order_form.prefecture_id =''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'postal_codeが空では購入できない' do
        @order_form.city =''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("City can't be blank")
      end
      it 'blockが空では購入できない' do
        @order_form.block =''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Block can't be blank")
      end
      it 'phone_numberが空では購入できない' do
        @order_form.phone_number =''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
      end
      it "tokenが空では登録できない" do
        @order_form.token = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Token can't be blank")
      end
      it 'userが紐付いていないと購入できない' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("User can't be blank")
      end
      it 'userが紐付いていないと購入できない' do
        @order_form.item_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Item can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと購入できない' do
        @order_form.postal_code = '1234567'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Postal code input correctly')
      end
      it 'postal_codeの数字が上3桁下4桁でないと購入できない' do
        @order_form.postal_code = '123-456'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Postal code input correctly')
      end
      it 'phone_numberが半角数字のみでないと購入できない' do
        @order_form.phone_number ='012-3456-789'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number Input only number")
      end
      it 'phone_numberが10桁未満だと購入できない' do
        @order_form.phone_number ='012345678'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number is too short (minimum is 10 characters)")
      end
      it 'phone_numberが12桁以上だと購入できない' do
        @order_form.phone_number ='012345678910'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
      end
    end

  end
end  
