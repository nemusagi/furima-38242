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
        expect(@order_form.errors.full_messages).to include("郵便番号を入力してください")
      end
      it 'prefecture_idで「---」が選択されている場合は購入できない' do
        @order_form.prefecture_id = 1
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("都道府県を入力してください")
      end
      it 'postal_codeが空では購入できない' do
        @order_form.city =''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'blockが空では購入できない' do
        @order_form.block =''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("番地を入力してください")
      end
      it 'phone_numberが空では購入できない' do
        @order_form.phone_number =''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("電話番号を入力してください")
      end
      it "tokenが空では登録できない" do
        @order_form.token = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
      it 'userが紐付いていないと購入できない' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("ユーザーを入力してください")
      end
      it 'itemが紐付いていないと購入できない' do
        @order_form.item_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("商品を入力してください")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと購入できない' do
        @order_form.postal_code = '1234567'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('郵便番号を正しく入力してください')
      end
      it 'postal_codeの数字が上3桁下4桁でないと購入できない' do
        @order_form.postal_code = '123-456'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('郵便番号を正しく入力してください')
      end
      it 'phone_numberが半角数字のみでないと購入できない' do
        @order_form.phone_number ='012-3456-789'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("電話番号は半角数字のみで入力してください")
      end
      it 'phone_numberが10桁未満だと購入できない' do
        @order_form.phone_number ='012345678'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("電話番号は10文字以上で入力してください")
      end
      it 'phone_numberが12桁以上だと購入できない' do
        @order_form.phone_number ='012345678910'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("電話番号は11文字以内で入力してください")
      end
    end

  end
end  
