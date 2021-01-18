require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @order_address = FactoryBot.build(:order_address)
  end

  describe '商品購入機能' do
    context '商品の購入ができる時' do
      # - 必要な情報を適切に入力すると、商品の購入ができること
      it 'tokenとpostal_codeとprefecture_idとmunicipalityとaddressとbuilding_nameとphone_numberが存在すれば商品の出品ができる' do
        expect(@order_address).to be_valid
      end
      # - 建物名が空でも、商品の購入ができること
      it 'building_nameが空でも商品の出品ができる' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end

    context '商品の購入ができない時' do
      # - クレジットカード情報は必須であり、正しいクレジットカードの情報で無いときは決済できないこと
      it 'tokenが空では商品の購入ができない' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      # - 配送先の情報として、郵便番号・都道府県・市区町村・番地・電話番号が必須であること
      # - 郵便番号が必須であること
      it 'postal_codeが空では商品の購入ができない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      # - 郵便番号にはハイフンが必要であること（123-4567となる）
      it 'postal_codeにハイフンが含まれていなければ商品の購入ができない' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code Input correctly')
      end
      # - 郵便番号は半角数字のみ保存可能であること
      it 'postal_codeが全角数字では商品の出品ができない' do
        @order_address.postal_code = '１２３-４５６７'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code Input correctly')
      end
      it 'postal_codeが半角英数混合では商品の出品ができない' do
        @order_address.postal_code = '123-abcd'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code Input correctly')
      end
      it 'postal_codeが半角英語では商品の出品ができない' do
        @order_address.postal_code = 'abc-defg'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code Input correctly')
      end
      # - 都道府県が必須であること
      it 'prefecture_idが空では商品の購入ができない' do
        @order_address.prefecture_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'prefecture_idが1では商品の出品ができない' do
        @order_address.prefecture_id = '1'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Prefecture Select')
      end
      # - 市区町村が必須であること
      it 'municipalityが空では商品の購入ができない' do
        @order_address.municipality = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Municipality can't be blank")
      end
      # - 番地が必須であること
      it 'addressが空では商品の購入ができない' do
        @order_address.address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address can't be blank")
      end
      # - 電話番号が必須であること
      it 'phone_numberが空では商品の購入ができない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      # - 電話番号にはハイフンは不要で、11桁以内であること（09012345678となる）
      it 'phone_numberにハイフンが含まれていると商品の購入ができない' do
        @order_address.phone_number = '090-1234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number Input only number')
      end
      it 'phone_numberが12桁以上では商品の購入ができない' do
        @order_address.phone_number = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
      end
      # - 電話番号は半角数字のみ保存可能であること
      it 'phone_numberが全角数字では商品の出品ができない' do
        @order_address.phone_number = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number Input only number')
      end
      it 'phone_numberが半角英数混合では商品の出品ができない' do
        @order_address.phone_number = '0901234abcd'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number Input only number')
      end
      it 'phone_numberが半角英語では商品の出品ができない' do
        @order_address.phone_number = 'abcdefghijk'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number Input only number')
      end
    end
  end
end

# bundle exec rspec spec/models/order_address_spec.rb
# @order_address.valid?
# @order_address.errors
# @order_address.errors.full_messages
