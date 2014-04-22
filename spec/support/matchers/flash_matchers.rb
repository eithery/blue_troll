module FlashMatchers
  def should_flash_success(message)
    flash[:success].should == message
  end

  def should_flash_warning(message)
    flash[:warning].should == message
  end

  def should_flash_error(message)
    flash[:danger].should == message
  end
end
