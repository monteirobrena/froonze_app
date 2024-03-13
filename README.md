# Froonze App

## Task
Write a spec for `set_field_service.rb`.

### Approach

To implement a clean and intelligible specification for the service, it was necessary to refactor the service itself and implement some techniques to make the service agnostic regarding the type of attribute being validated and formatted.

Another important change was made to the client model to use native validation for the email attribute. Keeping the code simple and avoiding rewriting Rails functionality, made code more compatible with the two most important Rails principles (**Don't Repeat Yourself and Convention Over Configuration**).

### Last version of `set_field_service.rb`

If you need to add a new method to be called based on the type, add it to the `hash_method_by_type` following the strucutre: `type: :method_name`.

```ruby
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
```

### First version of `set_field_service.rb`

```ruby
class SetFieldService
  def call(customer:, field_name:, new_value:)
    ActiveRecord::Base.transaction do
      case field_name
      when 'email'
        return { error: 'You need to specify an email for this customer.' } if new_value.blank?

        new_value = new_value.strip.downcase

        return { error: "Can't save email. Invalid value: '#{new_value}'" } if EmailValidator.valid?(new_value) != true

        customer.email = new_value
        customer.verified = 0

        begin
          customer.save!
        rescue ActiveRecord::RecordNotUnique
          return { error: 'Email already exists.' }
        rescue StandardError => e
          return { error: e.to_s }
        end
        return {}

      when 'first_name'
        customer.first_name = new_value.strip
      when 'last_name'
        customer.last_name = new_value.strip
      when 'phone'
        customer.phone = new_value.strip
      when 'title'
        customer.title = new_value.strip
      when 'role'
        customer.role = new_value.strip
      when 'score'
        customer.score = new_value.to_i
      else
        return { error: "Unknown field: '#{field_name}'" }
      end
      customer.save!

      return {}
    end
  end
end
```

## How to run

To run the tests you need to:

- clone it
- access the application folder
- install the dependencies
- run the migrations
- run the specs

```shell
$ git clone https://github.com/monteirobrena/froonze_app.git
$ cd froonze_app
$ bundle
$ rails db:migrate
$ rspec spec
```
