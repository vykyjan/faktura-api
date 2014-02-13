require 'spec_helper'

describe "clients/edit" do
  before(:each) do
    @client = assign(:client, stub_model(Client,
      :name => "MyString",
      :register => "MyString",
      :ic => "MyString",
      :dic => "MyString",
      :adress => "MyString",
      :bank_account => "MyString",
      :hdp => "MyString",
      :user => nil
    ))
  end

  it "renders the edit client form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", client_path(@client), "post" do
      assert_select "input#client_name[name=?]", "client[name]"
      assert_select "input#client_register[name=?]", "client[register]"
      assert_select "input#client_ic[name=?]", "client[ic]"
      assert_select "input#client_dic[name=?]", "client[dic]"
      assert_select "input#client_adress[name=?]", "client[adress]"
      assert_select "input#client_bank_account[name=?]", "client[bank_account]"
      assert_select "input#client_hdp[name=?]", "client[hdp]"
      assert_select "input#client_user[name=?]", "client[user]"
    end
  end
end
