require 'spec_helper'

describe "clients/index" do
  before(:each) do
    assign(:clients, [
      stub_model(Client,
        :name => "Name",
        :register => "Register",
        :ic => "Ic",
        :dic => "Dic",
        :adress => "Adress",
        :bank_account => "Bank Account",
        :hdp => "Hdp",
        :user => nil
      ),
      stub_model(Client,
        :name => "Name",
        :register => "Register",
        :ic => "Ic",
        :dic => "Dic",
        :adress => "Adress",
        :bank_account => "Bank Account",
        :hdp => "Hdp",
        :user => nil
      )
    ])
  end

  it "renders a list of clients" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Register".to_s, :count => 2
    assert_select "tr>td", :text => "Ic".to_s, :count => 2
    assert_select "tr>td", :text => "Dic".to_s, :count => 2
    assert_select "tr>td", :text => "Adress".to_s, :count => 2
    assert_select "tr>td", :text => "Bank Account".to_s, :count => 2
    assert_select "tr>td", :text => "Hdp".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
