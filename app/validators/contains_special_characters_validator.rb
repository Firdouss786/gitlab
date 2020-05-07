class ContainsSpecialCharactersValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)

    if value =~ /[^A-Za-z0-9]+/
      true
    else
      record.errors.add(attribute, "must contain at least 1 special character")
    end

  end
end
