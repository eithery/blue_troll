module DomainModelMatchers
  def should_assign(assignments)
    yield if block_given?
    assignments.each { |key, val| assigns[key].should eq(val) }
  end
end
