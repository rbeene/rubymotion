class Photo 

  attr_accessor :photoName
  attr_accessor :photoImage

	def encodeWithCoder(encoder)
		encoder.encodeObject(@photoName,forKey:"photoName")
		encoder.encodeObject(@photoImage,forKey:"photoImage")
	end

	def initWithCoder(decoder)
		self.init
		@photoName = decoder.decodeObjectForKey("photoName")
		@photoImage = decoder.decodeObjectForKey("photoImage")
		self
	end

end