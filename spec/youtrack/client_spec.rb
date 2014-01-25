require "spec_helper"

describe Youtrack::Client do
  let(:client) { Youtrack::Client.new }

  describe "attributes" do 

    # Mutators
    it { should respond_to(:url=) }
    it { should respond_to(:login=) }
    it { should respond_to(:password=) }
    it { should respond_to(:cookies=) }
    it { should respond_to(:connection=) }
    it { should respond_to(:admin=) }

    # Accessors
    it { should respond_to(:admin?) }
    it { should respond_to(:connected?) }
    it { should respond_to(:credentials_hash) }
    it { should respond_to(:endpoint) }
  end

  describe "resources" do
    it { should respond_to(:users) }
    it { should respond_to(:projects) }
    it { should respond_to(:issues) }
  end

end
