require 'rails_helper'

RSpec.describe CartAddress, type: :model do
  describe '商品の購入' do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    before do
      @cart_address = FactoryBot.build(:cart_address, user_id: user.id, item_id: item.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@cart_address).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @cart_address.building = ''
        expect(@cart_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できないこと' do
        @cart_address.postal_code = ''
        @cart_address.valid?
        expect(@cart_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @cart_address.postal_code = '1234567'
        @cart_address.valid?
        expect(@cart_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'prefecture_idを選択していないと保存できないこと' do
        @cart_address.prefecture_id = ''
        @cart_address.valid?
        expect(@cart_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'prefecture_idに[--]を選択していると保存できないこと' do
        @cart_address.prefecture_id = '1'
        @cart_address.valid?
        expect(@cart_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できないこと' do
        @cart_address.city = ''
        @cart_address.valid?
        expect(@cart_address.errors.full_messages).to include("City can't be blank")
      end
      it 'addresesが空だと保存できないこと' do
        @cart_address.addresses = ''
        @cart_address.valid?
        expect(@cart_address.errors.full_messages).to include("Addresses can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        @cart_address.phone_number = ''
        @cart_address.valid?
        expect(@cart_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが10桁以上11桁以内の半角数値のみ保存可能であること' do
        @cart_address.phone_number = '090-1234-5678'
        @cart_address.valid?
        expect(@cart_address.errors.full_messages).to include('Phone number Input only number')
      end
      it 'tokenが空だと保存できないこと' do
        @cart_address.token = ''
        @cart_address.valid?
        expect(@cart_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'userが紐付いていないと保存できないこと' do
        @cart_address.user_id = nil
        @cart_address.valid?
        expect(@cart_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @cart_address.item_id = nil
        @cart_address.valid?
        expect(@cart_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
