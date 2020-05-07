class ContainsUpperCaseValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)

    if value =~ /[A-Z]+/
      true
    else
      record.errors.add(attribute, "must contain at least 1 upper case character")
    end

  end
end
