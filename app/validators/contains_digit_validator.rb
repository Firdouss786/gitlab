class ContainsDigitValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)

    if value =~ /[0-9]+/
      true
    else
      record.errors.add(attribute, "must contain at least 1 digit")
    end

  end
end
