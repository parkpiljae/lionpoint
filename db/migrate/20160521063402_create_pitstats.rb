class CreatePitstats < ActiveRecord::Migration
  def change
    create_table :pitstats do |t|

      t.integer :ed #자책점
      t.float :inn #이닝수
      t.integer :fb #볼넷
      t.integer :hit #피안타
      t.integer :perr #폭투
      t.integer :hr
      t.integer :losepitcher #패전투수
      t.integer :qualstartnowin #퀄스, 승리못함
      t.integer :winpitcher #승리투수
      t.integer :save_pit #세이브
      t.integer :allpitch #완투
      t.integer :allpitchnoscore #완봉
      t.date :game_date #경기날짜
      t.string :player_name
      t.integer :win_lose
      t.float :dpoint
      t.integer :holdpitch
      t.timestamps null: false
    end
  end
end
