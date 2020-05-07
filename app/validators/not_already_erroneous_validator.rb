class NotAlreadyErroneousValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)

    if record.changes[attribute]
      if record.changes[attribute].first != Fault.states[:error]
        true
      else
        record.errors.add(attribute, "can't be changed because it's already marked as an error")
      end
    end

  end
end
