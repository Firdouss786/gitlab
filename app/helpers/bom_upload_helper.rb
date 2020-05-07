module BomUploadHelper

  require 'rubyXL'

  def parse_excel?(file, config)

    return [ false, "File or config missing" ] if file.nil? || config.nil?

    workbook = RubyXL::Parser.parse(file)
    worksheet = workbook['BOM'] || workbook[0]
    headings = worksheet[0].cells.map { |c| c.value }

    # product_categories
    pc_name = headings.index('Product Family')
    pc_product_type = headings.index('Product Family Type (ROTABLE, CONSUMABLE)')
    pc_product_description = headings.index('Product Family description')
    return [ false, "Upload unsuccessful, missing reuqired columns for Product Family." ] if pc_name.nil? || pc_product_type.nil? || pc_product_description.nil?

    #products
    p_part_no = headings.index('Product Part Number')
    p_name = headings.index('Product Name')
    p_price = headings.index('Product Price')
    p_shelf_life = headings.index('Product Shelf Life')
    p_description = headings.index('Product Description')
    return [ false, "Upload unsuccessful, missing reuqired columns for Products." ] if p_part_no.nil? || p_name.nil? || p_price.nil? || p_shelf_life.nil? || p_description.nil?

    #allotment
    pa_quantity = headings.index('Quantity')
    return [ false, "Upload unsuccessful, missing reuqired column: Quantity." ] if pa_quantity.nil?

    rows_added = 0

    worksheet.drop(1).each_with_index do |r, index|

      # product category
      if r.cells[pc_name].value.present?
        pt = (['ROTABLE', 'CONSUMABLE'].include? r.cells[pc_product_type].value.upcase) ? r.cells[pc_product_type].value.upcase : 'CONSUMABLE'
        pc = ProductCategory.find_by_name(r.cells[pc_name].value) || ProductCategory.new(name: r.cells[pc_name].value, product_type: pt, description: r.cells[pc_product_description].value)
        if pc.valid?
          pc.save! if pc.new_record?
        else
          return [ false, "Product Family information is not valid in row #{index+1}." ]
        end
      else
        return [ false, "Product Family is missing in row #{index+1}." ]
      end

      # product
      if r.cells[p_part_no].value.present?
        p = Product.find_by_part_number(r.cells[p_part_no].value) || Product.new(part_number: r.cells[p_part_no].value, name: r.cells[p_name].value, price: r.cells[p_price].value.to_i, shelf_life: r.cells[p_shelf_life].value.to_i, description: r.cells[p_description].value, product_category: pc)
        if p.valid?
          p.save! if p.new_record?
        else
          return [ false, "Product information is not valid in row #{index+1}." ]
        end
      else
        return [ false, "Product Part Number is missing in row #{index+1}." ]
      end

      # product allotment
      pa = ProductAllotment.find_or_initialize_by(product: p, quantity: r.cells[pa_quantity].value.to_i || 0, fleet: config)
      if pa.new_record?
        pa.save!
        rows_added += 1
      end

    end
    return [ true, "Added #{rows_added} rows successfully." ]
  end

  def excel_file?(file)
    File.extname(file) == '.xlsx'
  end

end
