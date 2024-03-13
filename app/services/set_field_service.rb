class SetFieldService
  def call(customer:, field_name:, new_value:)
    return {
      error: I18n.t('activerecord.errors.messages.models.customer.unknown_field', value: field_name)
    } unless Customer.attribute_names.include?(field_name)

    hash_method_by_type = {
      integer: :to_i,
      string: :strip
    }

    ActiveRecord::Base.transaction do
      method_to_call = hash_method_by_type[Customer.attribute_types[field_name].type]
      customer[field_name] = new_value.send(method_to_call)

      customer.save!

      return {}
    end
  end
end
