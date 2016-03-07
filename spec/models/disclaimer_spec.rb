# Eithery Lab, 2016.
# Disclaimer model specs.

require 'rails_helper'

describe Disclaimer do
  subject(:disclaimer) { Disclaimer.new }
  it { should respond_to :to_pdf, :file_name }


  describe '#file_name' do
  end
end
