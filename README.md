# テーブル設計

## usersテーブル

| Column             | Type        | Options                   |
| ------------------ | ----------- | ------------------------- |
| nickname           | string      | null: false               |
| email              | string      | null: false, unique: true |
| encrypted_password | string      | null: false               |
| last_name          | string      | null: false               |
| first_name         | string      | null: false               |
| last_name_kana     | string      | null: false               |
| birth_date         | string      | null: false               |

### Association
- has_many :items
- has_one :address

## itemsテーブル

| Column              | Type        | Options                        |
| ------------------- | ----------- | ------------------------------ |
| name                | string      | null: false                    |
| info                | text        | null: false                    |
| category            | string      | null: false                    |
| sales_status        | string      | null: false                    |
| shipping_fee_status | string      | null: false                    |
| prefecture          | string      | null: false                    |
| scheduled_delivery  | string      | null: false                    |
| price               | string      | null: false                    |
| user                | references  | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :cart

## addressesテーブル

| Column              | Type        | Options                        |
| ------------------- | ----------- | ------------------------------ |
| postal_code         | string      | null: false                    |
| prefecture          | string      | null: false                    |
| city                | string      | null: false                    |
| addresses           | string      | null: false                    |
| building            | string      | null: true                     |
| phone_number        | string      | null: false                    |
| user                | references  | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :cart

## cartsテーブル

| Column              | Type        | Options                        |
| ------------------- | ----------- | ------------------------------ |
| item                | references  | null: false, foreign_key: true |

### Association
- belongs_to :item
- has_one :address