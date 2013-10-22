class InvoicesController < ApplicationController
  before_filter :show_navbar

  def index
    @invoices = Invoice.all
    @clients = Client.all
  end

  def new
    @clients = Client.all
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.new(post_params)

    @invoice.save
    redirect_to @invoice
  end

  def show
    @invoice = Invoice.find(params[:id])
    @user = current_user[:id]

    respond_to do |format|
      format.html
      format.pdf {
        html = render_to_string(:layout => "pdf.html.erb" , :action => "show.html.erb", :formats => [:html], :handler => [:erb])
        kit = PDFKit.new(html)
        kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/application.css"
        send_data(kit.to_pdf, :filename => "#{clean_string(@event.title)}.pdf", :type => 'application/pdf')
        return # to avoid double render call
      }
     end
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])

    if @invoice.update(params[:invoice].permit(:description, :price))
      redirect_to @invoice
    else
      render 'edit'
    end
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy

    redirect_to invoices_path
  end

  def download
    kit = PDFKit.new(render_to_string(:show, :layout => false))
    kit.stylesheets << Rails.application.assets['application.css'].pathname
    kit.to_file("#{file_date_string}.pdf")
    # snip
  end

  private
  def post_params

    params.require(:invoice).permit(:description, :price, :client_id)
  end

  def show_navbar
    @show_navbar = false
  end
end