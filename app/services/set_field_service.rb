class SetFieldService
  def call(customer:, field_name:, new_value:)
    ActiveRecord::Base.transaction do
      return { error: "Unknown field: '#{field_name}'" } unless Customer.attribute_names.include?(field_name)

      customer[field_name] = new_value.to_i if Customer.attribute_types[field_name].type == :integer
      customer[field_name] = new_value.strip if Customer.attribute_types[field_name].type == :string

      customer.save!

      return {}
    end
  end
end
