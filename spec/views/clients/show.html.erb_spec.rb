require 'spec_helper'

describe "clients/show" do
  before(:each) do
    @client = assign(:client, stub_model(Client,
      :name => "Name",
      :register => "Register",
      :ic => "Ic",
      :dic => "Dic",
      :adress => "Adress",
      :bank_account => "Bank Account",
      :hdp => "Hdp",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Register/)
    rendered.should match(/Ic/)
    rendered.should match(/Dic/)
    rendered.should match(/Adress/)
    rendered.should match(/Bank Account/)
    rendered.should match(/Hdp/)
    rendered.should match(//)
  end
end
