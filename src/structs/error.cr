struct Error
  def initialize(@status_code : Int32, @message : String)
  end

  getter :status_code
  getter :message
end
