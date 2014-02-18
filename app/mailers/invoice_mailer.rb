class InvoiceMailer < ActionMailer::Base
  default from: 'notifications@example.com'
  def invoice_info(invoice, current_user)
    @clients = invoice.client
    @invoice = invoice


   # attachments["#{Invoice.object_id}.pdf"] = File.read('#{Rails.root}/tmp/documents/"#{Invoice.object_id}"')
    attachments["'#{Invoice.object_id}'.pdf"] = File.read("#{Rails.root}/tmp/documents/#{Invoice.object_id}.pdf")
    mail :to => @clients.email, :subject => "Invoice to partner"
  end


  def reminder(invoice, current_user)
    @clients = invoice.client
    @invoice = invoice


    mail :to => @clients.email, :subject => "Invoice to partner"
  end
end
