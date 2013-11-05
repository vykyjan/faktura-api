# coding: utf-8
require "prawn"
require "prawn/layout"
require "prawn/measurement_extensions"

module Tisk

  def invoice_one(invoice)
    # Rails.root.join("tmp/dodaci-listy.pdf")
    Prawn::Document.generate(Rails.root.join('tmp', "faktura.pdf"),:page_size   => "A4", :margin => [1.5.cm,1.5.cm,1.5.cm,1.5.cm],
      :info => {
      :Title        => "#{invoice.vs}",
      :Author       => "Fulfillment ELMS service",
      :Subject      => "Faktura #{invoice.vs}",
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
      
      font "OpenSans"
      font_size 10
      
      define_grid(:columns => 2, :rows => 40, :gutter => 10)
      
      grid([0,0], [7,0]).bounding_box do
        # logo
        # qr platba
      end

      grid([0,1], [7,1]).bounding_box do
        text "FAKTURA - #{invoice.vs}", :size => 18, :align => :right
        text "Daňový doklad", :size => 12, :align => :right
        move_down font.height
        table [ 
          ["Datum vystavení:", "#{package.date_prepare.strftime('%d. %m. %Y')}"],
          ["Datum zdan. plnění:", "#{package.date_prepare.strftime('%d. %m. %Y')}"],
          ["Datum splatnosti:", "#{package.date_prepare.advance(:weeks => 2).strftime('%d. %m. %Y')}"],
          [" ", " "],
          ["Forma úhrady:", "Bankovním převodem"],
          ["Variabilní symbol:", "#{package.vs}"],
          ["Číslo bankovního účtu:", "#{package.client.account}"],
          ["IBAN:", "<font size='8'>#{package.client.iban}</font>"],
          ["SWIFT", "#{package.client.swift}"]
          ], :position => :right,
          :cell_style => { :padding => [0,0,0,10], :borders => [],:align => :right, :inline_format => true}
      end

      grid([8,0], [8,1]).bounding_box do
        stroke_horizontal_rule
      end

      grid([9,0], [13,0]).bounding_box do
        text "Dodavatel", :style => :bold
        text "#{package.client.name}"
        text "#{package.client.street}"
        text "#{package.client.zip} #{package.client.town}"
        move_down font.height
        text "IČ: #{package.client.ic}"
        text "DIČ: #{package.client.dic}"
      end

      grid([9,1], [13,1]).bounding_box do
        text "Odběratel", :style => :bold
        text "#{package.customer.first_name} #{package.customer.surname}"
        text "#{package.customer.street}"
        text "#{package.customer.zip} #{package.customer.town}"
        move_down font.height
        text "IČ: #{package.customer.ico}"
        text "DIČ: #{package.customer.dic}"
      end

      grid([14,0], [14,1]).bounding_box do
        stroke_horizontal_rule
      end
      
      grid([15,0], [37,1]).bounding_box do
        text "Fakturujeme vám následující služby", :style => :italic
        move_down font.height
        if package.client.dph
          data = [["Položky", "Počet MJ", "DPH", "Cena za MJ", "Cena s DPH"]]
        else
          data = [["Položky", "Počet MJ", " ", "Cena za MJ", "Cena celkem"]]
        end
        total = 0
        dph = {}
        package.document_items.each do |p|
          if package.client.dph
            data.push([p.product.name, p.pcs, p.tax,sprintf("%.2f",p.price),sprintf("%.2f",p.price * p.pcs)])
            if dph["#{p.tax}"].nil?
              dph["#{p.tax}"] = 0
            end
            dph["#{p.tax}"] += p.price * p.pcs 
            total += p.price * p.pcs
          else
            data.push([p.product.name, p.pcs, " ",sprintf("%.2f",p.price),sprintf("%.2f",p.price * p.pcs)])
            total += p.price * p.pcs
          end
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
        if package.client.dph
          zaklad = 0
          dph.each do |k,v|
            zaklad += (v.to_f / (1 + (k.to_f/100)))
            data.push(["DPH #{k.to_f}% ", sprintf("%.2f " + package.order.currency.name,v.to_f-zaklad)])
          end
          data.insert(0,["Celkem bez DPH", sprintf("%.2f " + package.order.currency.name,zaklad)])
        end
        data.push([" ", " "])
        data.push(["<font size='16'>Celkem</font>", "<font size='16'>" + sprintf("%.2f " + package.order.currency.name,total) + "</font>"])
        table(data, :cell_style => { :padding => [0,0,0,10], :borders => [],:align => :right, :inline_format => true}, :position => :right)            
      end

      grid([38,0], [39,1]).bounding_box do
        text "Společnost je zapsána v obchodním rejstříku vedeném Městským soudem v Praze oddíl C, vložka 172484.", :size => 8, :align => :right, :color => "cccccc"
        text "Fakturu vyrobil robot na http://fulfillment.elmsservice.cz", :size => 8, :align => :right, :color => "cccccc"
      end
          
    end  
  end

  def invoice_all(packages)
    # Rails.root.join("tmp/dodaci-listy.pdf")
    Prawn::Document.generate(Rails.root.join('tmp', "faktury.pdf"),:page_size   => "A4", :margin => [1.5.cm,1.5.cm,1.5.cm,1.5.cm],
      :info => {
      :Title        => "Faktury",
      :Author       => "Fulfillment ELMS service",
      :Subject      => "Faktury",
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
      
      font "OpenSans"
      font_size 10
      
      packages.each do |package|
            
        define_grid(:columns => 2, :rows => 40, :gutter => 10)
      
        grid([0,0], [7,0]).bounding_box do
          # logo
          # qr platba
        end

        grid([0,1], [7,1]).bounding_box do
          text "FAKTURA - #{package.vs}", :size => 18, :align => :right
          text "Daňový doklad", :size => 12, :align => :right
          move_down font.height
          table [ 
            ["Datum vystavení:", "#{package.date_prepare.strftime('%d. %m. %Y')}"],
            ["Datum zdan. plnění:", "#{package.date_prepare.strftime('%d. %m. %Y')}"],
            ["Datum splatnosti:", "#{package.date_prepare.advance(:weeks => 2).strftime('%d. %m. %Y')}"],
            [" ", " "],
            ["Forma úhrady:", "Bankovním převodem"],
            ["Variabilní symbol:", "#{package.vs}"],
            ["Číslo bankovního účtu:", "#{package.client.account}"],
            ["IBAN:", "<font size='8'>#{package.client.iban}</font>"],
            ["SWIFT", "#{package.client.swift}"]
            ], :position => :right,
            :cell_style => { :padding => [0,0,0,10], :borders => [],:align => :right, :inline_format => true}
        end

        grid([8,0], [8,1]).bounding_box do
          stroke_horizontal_rule
        end

        grid([9,0], [13,0]).bounding_box do
          text "Dodavatel", :style => :bold
          text "#{package.client.name}"
          text "#{package.client.street}"
          text "#{package.client.zip} #{package.client.town}"
          move_down font.height
          text "IČ: #{package.client.ic}"
          text "DIČ: #{package.client.dic}"
        end

        grid([9,1], [13,1]).bounding_box do
          text "Odběratel", :style => :bold
          text "#{package.customer.first_name} #{package.customer.surname}"
          text "#{package.customer.street}"
          text "#{package.customer.zip} #{package.customer.town}"
          move_down font.height
          text "IČ: #{package.customer.ico}"
          text "DIČ: #{package.customer.dic}"
        end

        grid([14,0], [14,1]).bounding_box do
          stroke_horizontal_rule
        end
      
        grid([15,0], [37,1]).bounding_box do
          text "Fakturujeme vám následující služby", :style => :italic
          move_down font.height
          if package.client.dph
            data = [["Položky", "Počet MJ", "DPH", "Cena za MJ", "Cena s DPH"]]
          else
            data = [["Položky", "Počet MJ", " ", "Cena za MJ", "Cena celkem"]]
          end
          total = 0
          dph = {}
          package.document_items.each do |p|
            if package.client.dph
              data.push([p.product.name, p.pcs, p.tax,sprintf("%.2f",p.price),sprintf("%.2f",p.price * p.pcs)])
              if dph["#{p.tax}"].nil?
                dph["#{p.tax}"] = 0
              end
              dph["#{p.tax}"] += p.price * p.pcs 
              total += p.price * p.pcs
            else
              data.push([p.product.name, p.pcs, " ",sprintf("%.2f",p.price),sprintf("%.2f",p.price * p.pcs)])
              total += p.price * p.pcs
            end
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
          if package.client.dph
            zaklad = 0
            dph.each do |k,v|
              zaklad += (v.to_f / (1 + (k.to_f/100)))
              data.push(["DPH #{k.to_f}% ", sprintf("%.2f " + package.order.currency.name,v.to_f-zaklad)])
            end
            data.insert(0,["Celkem bez DPH", sprintf("%.2f " + package.order.currency.name,zaklad)])
          end
          data.push([" ", " "])
          data.push(["<font size='16'>Celkem</font>", "<font size='16'>" + sprintf("%.2f " + package.order.currency.name,total) + "</font>"])
          table(data, :cell_style => { :padding => [0,0,0,10], :borders => [],:align => :right, :inline_format => true}, :position => :right)            
        end

        grid([38,0], [39,1]).bounding_box do
          text "Společnost je zapsána v obchodním rejstříku vedeném Městským soudem v Praze oddíl C, vložka 172484.", :size => 8, :align => :right, :color => "cccccc"
          text "Fakturu vyrobil robot na http://fulfillment.elmsservice.cz", :size => 8, :align => :right, :color => "cccccc"
        end
        
        if package != packages.last
          start_new_page
        end
      end
          
    end  
  end


end
