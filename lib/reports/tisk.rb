# coding: utf-8
require "prawn"
require "prawn/layout"
require "prawn/measurement_extensions"

module Tisk

  def invoice_one(invoice, current_user)
    # Rails.root.join("tmp/dodaci-listy.pdf")
    Prawn::Document.generate(Rails.root.join('tmp', "faktura.pdf"),:page_size   => "A4", :margin => [1.5.cm,1.5.cm,1.5.cm,1.5.cm],
                             :info => {
                                 :Title        => "#{invoice.description}",
                                 :Author       => "Fulfillment ELMS service",
                                 :Subject      => "Faktura #{invoice.total_price}",
                                 :Keywords     => "elms, fulfillment",
                                 :Creator      => "Fulfillment ELMS service",
                                 :Producer     => "Prawn",
                                 :CreationDate => Time.now,
                                 :Grok         => "Test Property"}) do

      #stroke_axis

      font_families.update("OpenSans" => {
          :normal => Rails.root.join('fonts', "OpenSans-Regular.ttf"),
          :italic => Rails.root.join('fonts', "OpenSans-Italic.ttf"),
          :bold => Rails.root.join('fonts', "OpenSans-Bold.ttf"),
          :bold_italic => Rails.root.join('fonts', "OpenSans-BoldItalic.ttf")
      })

      #font "OpenSans"
      font_size 10

      define_grid(:columns => 2, :rows => 40, :gutter => 10)

      grid([0,0], [7,0]).bounding_box do
        # logo
        # qr platba
      end

      grid([0,1], [7,1]).bounding_box do
        text "FAKTURA - #{invoice.id}", :size => 18, :align => :right
        text "Daňový doklad", :size => 12, :align => :right
        move_down font.height
        table [
                 # ["Datum vystavení:", "#{invoice.date_of_issue('%d. %m. %Y')}"],
                  #["Datum zdan. plnění:", "#{invoice.date_of_the_chargeable_event('%d. %m. %Y')}"],
                  #["Datum splatnosti:", "#{invoice.due_date(:weeks => 2).strftime('%d. %m. %Y')}"],
                  #[" ", " "],
                  ["Forma úhrady:", "Bankovním převodem"],
                  ["Variabilní symbol:", "#{invoice.var_symbol}"],
                  ["Číslo bankovního účtu:", "#{invoice.client.bank_account}"],
                  ["IBAN:", "<font size='8'>#{invoice.client.IBAN}</font>"],
                  ["SWIFT", "#{invoice.client.SWIFT}"]
              ], :position => :right,
              :cell_style => { :padding => [0,0,0,10], :borders => [],:align => :right, :inline_format => true}
      end

      grid([8,0], [8,1]).bounding_box do
        stroke_horizontal_rule
      end

      grid([9,0], [13,0]).bounding_box do
        text "Dodavatel", :style => :bold
        text "#{current_user.name}"
        text "#{}"
        text "#{} #{}"
        move_down font.height
        text "IČ: #{}"
        text "DIČ: #{}"
      end

      grid([9,1], [13,1]).bounding_box do
        text "Odběratel", :style => :bold
        text "#{invoice.client.name} "
        text "#{invoice.client.street}"
        text "#{invoice.client.PSC} #{invoice.client.street2}"
        move_down font.height
        text "IČ: #{invoice.client.ic}"
        text "DIČ: #{invoice.client.dic}"
      end

      grid([14,0], [14,1]).bounding_box do
        stroke_horizontal_rule
      end

      grid([15,0], [37,1]).bounding_box do
        text "Fakturujeme vám následující služby", :style => :italic
        move_down font.height
        if invoice.client.hdp
          data = [["Položky", "Počet MJ", "DPH", "Cena za MJ", "Cena s DPH"]]
        else
          data = [["Položky", "Počet MJ", " ", "Cena za MJ", "Cena celkem"]]
        end
        total = 0
        dph = {}
        invoice.pieces.each do |p|

        end
        table(data,
              :cell_style => { :padding => [0,0,0,10], :borders => [],:align => :right},
              :row_colors => ["ffffff","dddddd"], :position => :center, :width => 500) do

          column(0).width = 250
          column(0). align = :left

        end
        move_down font.height
        stroke_horizontal_rule
        move_down font.height
        data = []
        if invoice.client.hdp
          zaklad = 0
          dph.each do |k,v|
            zaklad += (v.to_f / (1 + (k.to_f/100)))
            data.push(["DPH #{k.to_f}% ", sprintf("%.2f " + invoice.piece.last.try.(:text),v.to_f-zaklad)])
          end

        end
        data.push([" ", " "])
        data.push(["<font size='16'>Celkem</font>", "<font size='16'>" + sprintf("%.2f " + invoice,total_price) + "</font>"])
        table(data, :cell_style => { :padding => [0,0,0,10], :borders => [],:align => :right, :inline_format => true}, :position => :right)
      end

      grid([38,0], [39,1]).bounding_box do
        text "Společnost je zapsána v obchodním rejstříku vedeném Městským soudem v Praze oddíl C, vložka 172484.", :size => 8, :align => :right, :color => "cccccc"
        text "Fakturu vyrobil robot na http://fulfillment.elmsservice.cz", :size => 8, :align => :right, :color => "cccccc"
      end

    end
  end




end