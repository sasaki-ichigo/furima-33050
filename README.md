# FURIMAのER図

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birthday           | date   | null: false |

### Association

- has_many :order_users
- has_many :orders, through: order_users
- has_many :items

## orders テーブル

| Column                | Type       | Options                        |
| --------------------- | ---------- | ------------------------------ |
| postal_code           | text       | null: false                    |
| prefectures           | text       | null: false                    |
| municipality          | text       | null: false                    |
| address               | text       | null: false                    |
| building_name         | text       |                                |
| postal_code           | text       | null: false                    |
| order                 | references | null: false, foreign_key: true |

### Association

- has_many :order_users
- has_many :users, through: order_users
- has_many :items
- has_one :addresses


## addresses テーブル

| Column                | Type       | Options                        |
| --------------------- | ---------- | ------------------------------ |


### Association

- belongs_to :order

## order_users テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| order  | references | null: false, foreign_key: true |

### Association

- belongs_to :order
- belongs_to :user

## items テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| item_name   | string     | null: false                    |
| explanation | string     | null: false                    |
| category    | text       | null: false                    |
| state       | text       | null: false                    |
| burden      | text       | null: false                    |
| area        | text       | null: false                    |
| days        | text       | null: false                    |
| price       | text       | null: false                    |
| fee         | text       | null: false                    |
| profit      | text       | null: false                    |
| user        | references | null: false, foreign_key: true |
| order       | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :order