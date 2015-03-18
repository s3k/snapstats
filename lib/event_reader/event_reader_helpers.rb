module EventReaderHelpers

	def floor_time sec, fsec
		(Time.at(sec).to_f/fsec).floor*fsec
	end
	
end