json.array!(@clients) do |client|
  json.extract! client, :name, :register, :ic, :dic, :adress, :bank_account, :hdp, :user_id
  json.url client_url(client, format: :json)
end
