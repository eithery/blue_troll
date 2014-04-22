module FlashMatchers
  def expect_to_flash_success(message)
    yield if block_given?
    flash[:success].should == message
  end

  def expect_to_flash_warning(message)
    yield if block_given?
    flash[:warning].should == message
  end

  def expect_to_flash_error(message)
    yield if block_given?
    flash[:danger].should == message
  end
end
