class InvoiceMailer < ActionMailer::Base
  default from: 'notifications@example.com'
  def invoice_info(invoice, current_user)
    @clients = invoice.client
    @invoice = invoice

    attachments["'#{Invoice.object_id}'.pdf"] = File.read("#{Rails.root}/tmp/documents/#{Invoice.object_id}.pdf")
    mail :to => @clients.email, :subject => "Invoice to partner"
  end


  def reminder_email(invoice, current_user)
    @clients = invoice.client
    @invoice = invoice
    @current_user = current_user

    mail :to => @clients.email, :subject => "Upomínka"
  end

  def thanks(invoice, current_user)
    @clients = invoice.client
    @invoice = invoice
    @current_user = current_user

    mail :to => @clients.email, :subject => "Potvrzení platby "
  end
end
