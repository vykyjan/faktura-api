class InvoiceMailer < ActionMailer::Base
  default from: 'notifications@example.com'

  def invoice_info(invoice, current_user)
    @clients = invoice.client
    @invoice = invoice

    attachments['faktura.pdf'] = File.read('tmp/faktura.pdf')
    mail :to => @clients.email, :subject => "Invoice to partner"
  end

  def reminder(incoice, current_user)
    @clients = invoice.client
    @invoice = invoice


    mail :to => @clients.email, :subject => "Invoice to partner"
  end

end
