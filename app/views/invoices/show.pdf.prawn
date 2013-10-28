pdf.text "Faktura ##{@invoice.id}"

users = [["zákazník: ", "prodávající"],
["jméno: #{@invoice.client.name}", "#{current_user.name}"],
["#{@invoice.client.register}", "#{@current_user.register}", "#{@invoice.description}"],
["#{@invoice.client.ic}", "#{@current_user.ic}", "#{@invoice.price}"],
["#{@invoice.client.dic}", "#{@current_user.dic}"],
["#{@invoice.client.adress}", "#{@current_user.adress}"],
["#{@invoice.client.hdp}", "#{@current_user.dph}"],
["#{@invoice.client.bank_account}", "#{@current_user.bank_account}"]
 ]


pdf.table users
 
