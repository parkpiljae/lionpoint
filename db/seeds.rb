require 'open-uri'
require 'nokogiri'

 @url_data= Array.new
 @url_data =[
 			"http://casspoint.mbcplus.com/stats/scoreboard/?mode=view&get_date=2016-05-20&gamecode=20160213",
 			"http://casspoint.mbcplus.com/stats/scoreboard/?mode=view&get_date=2016-05-20&gamecode=20160214",
 			"http://casspoint.mbcplus.com/stats/scoreboard/?mode=view&get_date=2016-05-20&gamecode=20160215",
 			"http://casspoint.mbcplus.com/stats/scoreboard/?mode=view&get_date=2016-05-20&gamecode=20160216",
 			"http://casspoint.mbcplus.com/stats/scoreboard/?mode=view&get_date=2016-05-20&gamecode=20160217"]



























 
 			
@url_data.each do |t|

	doc = Nokogiri::HTML(Net::HTTP.get(URI(t)))
		
	#@stats = doc.css(".content//section:nth-child(5)//table:nth-child(2)//tbody//tr:nth-child(1)//td:nth-child(2)").inner_text
	@length = doc.css(".content//section:nth-child(5)//table:nth-child(2)//tbody//tr").length
	#원정팀 타자 (tr -> 1~length // td -> 이름:2, 타석:3, 안타수:5,홈런:9, 몸에맞는볼:13,삼진:14, 주루사:16,병살:18,실책:19)
	#@stats2 = doc.css(".content//section:nth-child(6)//table:nth-child(2)//tbody//tr:nth-child(1)//td:nth-child(2)").inner_text
	@length2 = doc.css(".content//section:nth-child(6)//table:nth-child(2)//tbody//tr").length
	#홈팀 타자
	#@stats3 = doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(1)//td:nth-child(1)").inner_text
	@length3 = doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr").length
	#원정팀 투수 (tr -> 1~length // td -> 이름 :1 , 승패세홀 :3 ,이닝:4, 피안타:8, 피홈런:9, 사구:10, 폭투:13, 자책점:15)
	
	#@stats4 = doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(1)//td:nth-child(1)").inner_text
	@l4 = doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr").length
	#홈팀 투수
	@stats5 = doc.css(".content//section:nth-child(4)//div:nth-child(2)//ul//li:nth-child(1)").inner_text
	#결승타
	if doc.css(".info//p//span").inner_text[0] == "패"  #원정

		wl =1
	else
		wl =0
	end
 
	if doc.css(".info//p//span").inner_text[1] == "패"  #홈

		wlh =1
	else
		wlh =0
	end	
 	
	#원정팀 타자전부
  	(1..@length).each do |x|
  		if doc.css(".content//section:nth-child(5)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(3)").inner_text.to_i ==0 
  			zero = 0.0001
  		else
  			zero = doc.css(".content//section:nth-child(5)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(3)").inner_text.to_i
  		end
  		dpp = (10.7)*wl 
  		dpp	+= (19.7)*doc.css(".content//section:nth-child(5)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(19)").inner_text.to_i
  		dpp	+= (23.3)*doc.css(".content//section:nth-child(5)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(18)").inner_text.to_i
  		dpp	+= (13.1)*doc.css(".content//section:nth-child(5)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(16)").inner_text.to_i 
  		dpp	+= (1.1)*doc.css(".content//section:nth-child(5)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(13)").inner_text.to_i
  		dpp	+= (9.7)*doc.css(".content//section:nth-child(5)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(14)").inner_text.to_i
  		dpp	+= (-10.1)*doc.css(".content//section:nth-child(5)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(9)").inner_text.to_i
  		dpp	+= (3.1)*doc.css(".content//section:nth-child(5)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(3)").inner_text.to_i
  		dpp	+= doc.css(".content//section:nth-child(5)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(5)").inner_text.to_i/zero*(-8.3)

       Hitstat.create(player_name: doc.css(".content//section:nth-child(5)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(2)").inner_text,
					pa: doc.css(".content//section:nth-child(5)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(3)").inner_text.to_i,
					hc: doc.css(".content//section:nth-child(5)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(5)").inner_text.to_i,
					hr: doc.css(".content//section:nth-child(5)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(9)").inner_text.to_i,
					hb: doc.css(".content//section:nth-child(5)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(13)").inner_text.to_i,
					so: doc.css(".content//section:nth-child(5)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(14)").inner_text.to_i,
					oob: doc.css(".content//section:nth-child(5)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(16)").inner_text.to_i,
					dp: doc.css(".content//section:nth-child(5)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(18)").inner_text.to_i,
					err: doc.css(".content//section:nth-child(5)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(19)").inner_text.to_i,
					game_date: doc.css("#gnb_gameDate").inner_text.to_date ,
					win_lose: wl,
					dpoint: dpp
					)

    end 


    #홈팀 타자전부
 	(1..@length2).each do |x|
 		if doc.css(".content//section:nth-child(6)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(3)").inner_text.to_i ==0 
  			zero = 0.0001
  		else
  			zero = doc.css(".content//section:nth-child(6)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(3)").inner_text.to_i
  		end

 		dpp = (10.7)*wlh
  		dpp	+=(19.7)*doc.css(".content//section:nth-child(6)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(19)").inner_text.to_i
  		dpp	+= (23.3)*doc.css(".content//section:nth-child(6)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(18)").inner_text.to_i
  		dpp	+= (13.1)*doc.css(".content//section:nth-child(6)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(16)").inner_text.to_i 
  		dpp	+= (1.1)*doc.css(".content//section:nth-child(6)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(13)").inner_text.to_i
  		dpp	+= (9.7)*doc.css(".content//section:nth-child(6)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(14)").inner_text.to_i
  		dpp	+= (-10.1)*doc.css(".content//section:nth-child(6)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(9)").inner_text.to_i
  		dpp	+= (3.1)* doc.css(".content//section:nth-child(6)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(3)").inner_text.to_i
  		dpp	+= doc.css(".content//section:nth-child(6)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(5)").inner_text.to_i / zero*(-8.3)
       Hitstat.create(player_name: doc.css(".content//section:nth-child(6)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(2)").inner_text,
					pa: doc.css(".content//section:nth-child(6)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(3)").inner_text.to_i,
					hc: doc.css(".content//section:nth-child(6)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(5)").inner_text.to_i,
					hr: doc.css(".content//section:nth-child(6)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(9)").inner_text.to_i,
					hb: doc.css(".content//section:nth-child(6)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(13)").inner_text.to_i,
					so: doc.css(".content//section:nth-child(6)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(14)").inner_text.to_i,
					oob: doc.css(".content//section:nth-child(6)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(16)").inner_text.to_i,
					dp: doc.css(".content//section:nth-child(6)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(18)").inner_text.to_i,
					err: doc.css(".content//section:nth-child(6)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(19)").inner_text.to_i,
					game_date: doc.css("#gnb_gameDate").inner_text.to_date,
					win_lose: wlh, 
					dpoint: dpp)

    end


	#원정팀 투수
	(1..@length3).each do |x|
		# 패전투수
		if doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(3)").inner_text == "패"
      				l = 1
      			else
      				l = 0
      	end
      	#승리투수 로직
      	if doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(3)").inner_text == "승"
      				w = 1
      			else
      				w = 0
      	end
      	#세이브투수
      	if doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(3)").inner_text == "세"
      				s = 1
      			else
      				s = 0
      	end
      	if doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(3)").inner_text == "홀"
      				h = 1
      			else
      				h = 0
      	end
      	#퀄스 승,패
      	if doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(4)").inner_text.to_f >=6 &&
      		doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(15)").inner_text.to_i <=3 &&
      		doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(3)").inner_text != "승"
      				q = 1
      			else
      				q = 0
      	end
		if doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(4)").inner_text.to_f >=6 &&
      		doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(15)").inner_text.to_i <=3 &&
      		doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(3)").inner_text != "승"
      				q = 1
      			else
      				q = 0
      	end
      	if @length4 = doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr").length == 1
      		if doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(15)").inner_text.to_i == 0
      			d = 1
      			r = 0
      		else
      			d = 0
      			r= 1 
      		end
		else
			d =0
			r = 0 
		end
		if doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(4)").inner_text.to_f == 0
			zero = 0.0001
		else
			zero = doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(4)").inner_text.to_f
		end	


		dp = (10.7)*wl
		 + doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(15)").inner_text.to_i/zero*(4.1)
		 + (1.1)*doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(10)").inner_text.to_i
		 +(2.3)*doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(8)").inner_text.to_i
		 +(10.1)*doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(9)").inner_text.to_i
		 +(7.1)*doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(13)").inner_text.to_i
		 +(15.1)*l
		 +(19.9)*q
		 +(-15.1)*w
		 +(-5.3)*h
		 +(-10.1)*s
		 +(-30.7)*r
		 +(-49.9)*d
		Pitstat.create(
				
      		    player_name: doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(1)").inner_text, 
      		    ed: doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(15)").inner_text.to_i,
      		    inn: doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(4)").inner_text.to_f,
      			fb: doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(10)").inner_text.to_i,
     		 	hit: doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(8)").inner_text.to_i, #피안타
      			perr: doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(13)").inner_text.to_i,
      			losepitcher: l,
      			qualstartnowin: q, 
      			winpitcher: w,
      			save_pit: s,
      		    allpitch: r,
      			allpitchnoscore: d,
      			game_date: doc.css("#gnb_gameDate").inner_text.to_date,
      			win_lose: wl,
      			hr: doc.css(".content//section:nth-child(7)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(9)").inner_text.to_i,
      			holdpitch: h,
      			dpoint: dp )

			
	
	end


	(1..@l4).each do |x|
		# 패전투수
		if doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(3)").inner_text == "패"
      				l = 1
      			else
      				l = 0
      	end
      	#승리투수 로직
      	if doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(3)").inner_text == "승"
      				w = 1
      			else
      				w = 0
      	end
      	#세이브투수
      	if doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(3)").inner_text == "세"
      				s = 1
      			else
      				s = 0
      	end
      	if doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(3)").inner_text == "홀"
      				h = 1
      			else
      				h = 0
      	end
      	#퀄스 승,패
      	if doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(4)").inner_text.to_f >=6 &&
      		doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(15)").inner_text.to_i <=3 &&
      		doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(3)").inner_text != "승"
      				q = 1
      			else
      				q = 0
      	end
		if doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(4)").inner_text.to_f >=6 &&
      		doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(15)").inner_text.to_i <=3 &&
      		doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(3)").inner_text != "승"
      				q = 1
      			else
      				q = 0
      	end
      	if @l4 = doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr").length == 1
      		if doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(15)").inner_text.to_i == 0
      			d = 1
      			r = 0
      		else
      			d = 0
      			r= 1 
      		end
		else
			d =0
			r = 0 
		end
		if doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(4)").inner_text.to_f == 0
			zero = 0.0001
		else
			zero = doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(4)").inner_text.to_f
		end	
		dp = (10.7)*wl
		dp += doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(15)").inner_text.to_i/zero*(4.1)
		dp += (1.1)*doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(10)").inner_text.to_i
		dp +=(2.3)*doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(8)").inner_text.to_i
		dp +=(10.1)*doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(9)").inner_text.to_i
		dp +=(7.1)*doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(13)").inner_text.to_i
		dp +=(15.1)*l
		dp +=(19.9)*q
		dp +=(-15.1)*w
		dp +=(-5.3)*h
		dp +=(-10.1)*s
		dp +=(-30.7)*r
		dp +=(-49.9)*d
		
		Pitstat.create(
				
      		    player_name: doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(1)").inner_text, 
      		    ed: doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(15)").inner_text.to_i,
      		    inn: doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(4)").inner_text.to_f,
      			fb: doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(10)").inner_text.to_i,
     		 	hit: doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(8)").inner_text.to_i, #피안타
      			perr: doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(13)").inner_text.to_i,
      			losepitcher: l,
      			qualstartnowin: q, 
      			winpitcher: w,
      			save_pit: s,
      		    allpitch: r,
      			allpitchnoscore: d,
      			game_date: doc.css("#gnb_gameDate").inner_text.to_date ,
      			win_lose: wlh,
      			hr:doc.css(".content//section:nth-child(8)//table:nth-child(2)//tbody//tr:nth-child(#{x})//td:nth-child(9)").inner_text.to_i,
      			dpoint: dp,
      			holdpitch: h
      			 )

			
	
	end
end
	#홈팀 투수
	
  # This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
