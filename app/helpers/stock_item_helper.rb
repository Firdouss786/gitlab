module StockItemHelper
	def certificate_string(certificates)
		unless certificates.blank?
			certificates.each{|c|
				return "#{c.governance} [#{c.reference}]"
			}
		end
	end
end