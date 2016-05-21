class CreateHitstats < ActiveRecord::Migration
  def change
    create_table :hitstats do |t|

      t.integer :err # 실책
      t.integer :dp #병살
      t.integer :oob #주루사
      t.integer :hb #사구
      t.integer :so #삼진
      t.integer :hc #안타수
      t.integer :hr #홈런
      t.integer :pa #타석수
      t.date :game_date #경기날짜
      t.string :player_name
      t.integer :win_lose #선수정보
      t.float :dpoint
      t.timestamps null: false
    end
  end
end