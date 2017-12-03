class VoteController < ApplicationController
	def index
	end

	def get_constituencies
		@places = District.find_by_name(params[:district]).places.pluck(:name)
		render partial: "constituency",:locals=>{places: @places}
	end

	def get_const_places
		district = District.find_by_name(params[:district_name])
		place = Place.where(district_id: district.id,name: params[:place_name]).first
		parties = place.parties
		congress_count = parties.where(name: "congress").first.vote_count

		total_votes_count = parties.pluck(:vote_count).sum

		bjp_count = parties.where(name: "bjp").first.vote_count

		bjp_percent = (bjp_count/total_votes_count.to_f*100).round(2)
		cng_percent = (congress_count/total_votes_count.to_f*100).round(2)

		vote_hash = {"bjp"=>{count: bjp_count,percent: bjp_percent},"congress"=>{count: congress_count,percent: cng_percent}}
		return render partial: "party",:locals=>{parties: place.parties,vote_hash: vote_hash,after_vote: eval(params[:after_vote])}
	end

	def apply_vote				
		district = District.find_by_name(params[:district])
		place = district.places.where(name: params[:place]).first
		party = place.parties.where(name: params[:part_name]).first		

		puts "REMOTE IP: #{request.remote_ip}"
		puts place.ip_tables.present?
		puts request.remote_ip
		puts place.ip_tables.pluck(:address).include?(request.remote_ip)

		if place.ip_tables.present? && (place.ip_tables.pluck(:address).include?(request.remote_ip) )
			render json: {status: false,ip_block: true}
		else						
			party.vote_count += 1
			status = (party.save!)? true : false		
			status = place.ip_tables.build({address: request.remote_ip}).save! if status
			render json: {status: status,party_name: party.name,ip_block: false}
		end		
	end
end