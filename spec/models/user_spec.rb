require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる時' do
      it 'nicknameとemailとpasswordとpassword_confirmationとlast_nameとfirst_nameとlast_name_kanaとfirst_name_kanaとbirthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが半角英数字混合で6文字以上であれば登録できる' do
        @user.password = '123abc'
        @user.password_confirmation = '123abc'
        expect(@user).to be_valid
      end
    end
    context '新規登録できない時' do
      # - ニックネームが必須であること
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      # - メールアドレスが必須であること
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      # - メールアドレスが一意性であること
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      # - メールアドレスは、@を含む必要があること
      it 'emailが@を含まない場合登録できない' do
        @user.email = 'testtest.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      # - パスワードが必須であること
      it 'passwordとpassword_confirmationが空では登録できない' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      # - パスワードは、6文字以上での入力が必須であること
      it 'passwordとpassword_confirmationが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      # - パスワードは、半角英数字混合での入力が必須であること
      it 'passwordとpassword_confirmationが半角英字だけでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end
      it 'passwordとpassword_confirmationが半角数字だけでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end
      it 'passwordとpassword_confirmationが全角英数字混合では登録できない' do
        @user.password = 'ａｂｃ１２３'
        @user.password_confirmation = 'ａｂｃ１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end
      it 'passwordとpassword_confirmationが全角英字半角数字では登録できない' do
        @user.password = 'ａｂｃ123'
        @user.password_confirmation = 'ａｂｃ123'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end
      it 'passwordとpassword_confirmationが半角英字全角数字では登録できない' do
        @user.password = 'abc１２３'
        @user.password_confirmation = 'abc１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end
      # - パスワードは、確認用を含めて2回入力すること
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include
      end
      it 'password_confirmationが存在してもpasswordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      # - パスワードとパスワード（確認用）、値の一致が必須であること
      it 'passwordとpassword_confirmationが不一致では登録できないこと' do
        @user.password = '123abc'
        @user.password_confirmation = '1234abcd'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      # - ユーザー本名は、名字と名前がそれぞれ必須であること
      it '名字が存在しても名前が空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it '名前が存在しても名字が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      # - ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること
      it '名字が半角英字では登録できない' do
        @user.last_name = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name Full-width characters')
      end
      it '名字が半角数字では登録できない' do
        @user.last_name = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name Full-width characters')
      end
      it '名字が半角英数字混合では登録できない' do
        @user.last_name = '123abc'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name Full-width characters')
      end
      it '名前が半角英字では登録できない' do
        @user.first_name = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name Full-width characters')
      end
      it '名前が半角数字では登録できない' do
        @user.first_name = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name Full-width characters')
      end
      it '名前が半角英数字混合では登録できない' do
        @user.first_name = '123abc'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name Full-width characters')
      end
      # - ユーザー本名のフリガナは、名字と名前でそれぞれ必須であること
      it '名字のフリガナが存在しても名前のフリガナが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it '名前のフリガナが存在しても名字のフリガナが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      # - ユーザー本名のフリガナは、全角（カタカナ）での入力が必須であること
      it '名字のフリガナが半角英字では登録できない' do
        @user.last_name_kana = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana Full-width katakana characters')
      end
      it '名字のフリガナが半角数字では登録できない' do
        @user.last_name_kana = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana Full-width katakana characters')
      end
      it '名字のフリガナが半角英数字混合では登録できない' do
        @user.last_name_kana = '123abc'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana Full-width katakana characters')
      end
      it '名前のフリガナが半角英字では登録できない' do
        @user.first_name_kana = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana Full-width katakana characters')
      end
      it '名前のフリガナが半角数字では登録できない' do
        @user.first_name_kana = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana Full-width katakana characters')
      end
      it '名前のフリガナが半角英数字混合では登録できない' do
        @user.first_name_kana = '123abc'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana Full-width katakana characters')
      end
      # - 生年月日が必須であること
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end

# binding.pry
# @user.errors.full_messages
# another_user.errors.full_messages
# bundle exec rspec spec/models/user_spec.rb
