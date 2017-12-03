class Place < ActiveRecord::Base
	has_many :parties
	belongs_to :district
	has_many :ip_tables

	def gcd_subs(arr)		
		count = 0 
		for x in (0..arr.length-2) do
			found , index = find_pair_index(arr)

			if (found)
				return arr.length + count
			end

			a = arr[x]
			b = arr[x+1]
			res = find_gcd(a,b)			
			if(res==arr[x])
				arr[x+1] = res
			else
				arr[x] = res
			end
			p arr
			count += 1
		end		
	end

	def find_pair_index(arr)		
		for x in (0..arr.length-2) do
			a = arr[x]
			b = arr[x+1]			

			res = find_gcd(a,b)

			if res==1						    	
				return true , x
			end			
		end
		return false,-1
	end

	def find_gcd(a,b)
		if(a==0 || b==0)
			return 0
		end

		if (a==b)
			return a
		end

		if(a>b)
			find_gcd(a-b,b)
		else
			find_gcd(a,b-a)
		end
	end

end