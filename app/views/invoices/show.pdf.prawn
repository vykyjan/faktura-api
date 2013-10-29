pdf.text "Faktura ##{@invoice.id}"

 table_data = [["<b>Dodavatel</b>
\n\nJméno:#{current_user.name}
\n Register:#{current_user.register}
\n Register:#{current_user.adress}
\n Register:#{current_user.ic}
\n Register:#{current_user.dic}
\n Register:#{current_user.dph}
",
 "<b>Zákazník</b>\n
\njméno:#{@invoice.client.name}
\nRegister:#{current_user.register}
\nRegister:#{current_user.adress}
\nRegister:#{current_user.ic}
\nRegister:#{current_user.dic}
\nRegister:#{current_user.dph}
\nRegister:#{current_user.register}
"], 
["text:#{@invoice.description}"], 
["cena:#{@invoice.price}"],
]

    pdf.table(table_data, :cell_style => { :inline_format => true })



 
