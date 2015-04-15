class String

  def truncate length = 10, ellipsis = '...'
		return self if self.length < length
	  len = 0
	  char_array = self.unpack("U*")
	  char_array.each_with_index do |c,i|
	    len = len + ( c < 127 ? 0.5 : 1 )
	    return char_array[0..i].pack("U*")+( i < char_array.length-1 ? ellipsis : "") if len >= length
	  end
	  return self
  end

end
