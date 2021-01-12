require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品の出品ができる時' do
      # - 必要な情報を適切に入力すると、商品の出品ができること
      it 'imageとnameとexplanationとcategory_idとstate_idとburden_idとprefecture_idとday_idとpriceとuser_idが存在すれば商品の出品ができる' do
        expect(@item).to be_valid
      end
    end

    context '商品の出品ができない時' do
      # - 商品画像を1枚つけることが必須であること
      it 'imageが空では商品の出品ができない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      # - 商品名が必須であること
      it 'nameが空では商品の出品ができない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      # - 商品の説明が必須であること
      it 'explanationが空では商品の出品ができない' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")
      end
      # - カテゴリーの情報が必須であること
      it 'category_idが空では商品の出品ができない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'category_idが1では商品の出品ができない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Category Select')
      end
      # - 商品の状態についての情報が必須であること
      it 'state_idが空では商品の出品ができない' do
        @item.state_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("State can't be blank")
      end
      it 'state_idが1では商品の出品ができない' do
        @item.state_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('State Select')
      end
      # - 配送料の負担についての情報が必須であること
      it 'burden_idが空では商品の出品ができない' do
        @item.burden_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Burden can't be blank")
      end
      it 'burden_idが1では商品の出品ができない' do
        @item.burden_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Burden Select')
      end
      # - 発送元の地域についての情報が必須であること
      it 'prefecture_idが空では商品の出品ができない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'prefecture_idが1では商品の出品ができない' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture Select')
      end
      # - 発送までの日数についての情報が必須であること
      it 'day_idが空では商品の出品ができない' do
        @item.day_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Day can't be blank")
      end
      it 'day_idが1では商品の出品ができない' do
        @item.day_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Day Select')
      end
      # - 価格についての情報が必須であること
      it 'priceが空では商品の出品ができない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      # - 価格の範囲が、¥300~¥9,999,999の間であること
      it '販売価格が300未満では商品の出品ができない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end
      it '販売価格が10000000以上では商品の出品ができない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end
      # - 販売価格は半角数字のみ保存可能であること
      it '販売価格が全角数字では商品の出品ができない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end
      it '販売価格が半角英数混合では商品の出品ができない' do
        @item.price = '123abc'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end
      it '販売価格が半角英語では商品の出品ができない' do
        @item.price = 'abcdef'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end
      it 'userが紐付いていないと保存できないこと' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
