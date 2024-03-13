describe SetFieldService do
  let(:set_field_service) { described_class }

  let(:first_name) { ' Rick ' }
  let(:customer) { Customer.create!({ first_name: first_name, email: "rick.grimes@twd.com" }) }

  describe '#call' do
    context 'create customer without service' do
      it { expect(customer.first_name).to eq(first_name) }

      it 'should not create customer without an email' do
        new_customer = Customer.create

        expect(new_customer.errors).to_not be_empty
        expect(new_customer.errors.messages[:email].first).to eql(I18n.t('activerecord.errors.models.customer.attributes.email.blank'))
      end

      it 'should not create customer with existent email' do
        Customer.create(email: "maggie.greene@twd.com")
        new_customer = Customer.create(email: "maggie.greene@twd.com")

        expect(new_customer.errors).to_not be_empty
        expect(new_customer.errors.messages[:email].first).to eql(I18n.t('activerecord.errors.models.customer.attributes.email.taken'))
      end

      it 'should not create customer with invalid email' do
        wrong_email = "maggie.greene.twd.com"
        new_customer = Customer.create(email: wrong_email)

        expect(new_customer.errors).to_not be_empty
        expect(new_customer.errors.messages[:email].first).to eql(I18n.t('activerecord.errors.models.customer.attributes.email.invalid', value: wrong_email))
      end
    end

    context 'create customer with service' do
      let(:new_first_name) { ' Carl ' }

      it 'should change the first_name' do
        call_result = set_field_service.new.call(
          customer: customer,
          field_name: 'first_name',
          new_value: new_first_name
        )
        expect(call_result).to eq({})
        expect(customer.first_name).to eq(new_first_name.strip)
      end
    end
  end
end