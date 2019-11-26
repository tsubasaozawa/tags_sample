# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

#　タグ付け機能実装  
## 0.事前準備  
・Tag-itのサイトよりjsファイルとcssファイルをダウンロード  
http://aehlke.github.io/tag-it/  

・ダウンロードしたファイルを、タグ機能を実装したいアプリの  
javascriptsとstylesheetsディレクトリにそれぞれ配置  

## 1.タグの表示  
ⅰ）Tag-itを使用するためのGemをインストール  
gem 'jquery-ui-rails'  
gem 'jquery-rails'  
gem 'rails-ujs'  

ⅱ）application.jsに以下を追加  
//= require jquery  
//= require jquery-ui  
//= require tag-it  
注）必ず「//= require_tree .」よりも上に記載すること  

ⅲ）適当なjsファイル（今回はtag.js）を作成し、タグの入力フィールドを実装  

ⅳ）_form.html.hamlにⅲ）で作成したタグの入力フィールドを表示する箇所を指定  
・%ul#post-tagsを追加（#post-tagsの部分は任意のIDでOK）  
・タグの編集用にhidden_field_tagを設定  

ⅴ）オートコンプリート用のヘルプメッセージが表示されないよう、  
適当なSCSSファイルに以下を記載  
.ui-helper-hidden-accessible {  
  display: none;  
}  

## 2.タグの保存  
ⅰ）タグ保存用のテーブルおよび、postsテーブルとの中間テーブルを作成  
ⅱ）各モデルのアソシエーションを設定  
ⅲ）postモデルにタグの更新処理内容を記載  
ⅳ）postsコントローラにタグの作成、編集、更新処理を追記  
ⅴ）postsコントローラのストロングパラメーターに:category_listを追加  