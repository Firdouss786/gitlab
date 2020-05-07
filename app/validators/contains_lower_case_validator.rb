class ContainsLowerCaseValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)

    if value =~ /[a-z]+/
      true
    else
      record.errors.add(attribute, "must contain at least 1 lower case character")
    end

  end
end
