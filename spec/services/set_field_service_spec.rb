describe SetFieldService do
  let(:set_field_service) { described_class }

  let(:first_name)  { ' Rick ' }
  let(:email)       { 'rick.grimes@twd.com' }
  let(:customer)    { Customer.build({ first_name: first_name, email: email }) }

  describe '#call' do
    context 'create customer with service' do
      it 'should change the first_name' do
        call_result = set_field_service.new.call(
          customer: customer,
          field_name: 'first_name',
          new_value: first_name
        )
        expect(call_result).to be_empty
        expect(customer.first_name).to eq(first_name.strip)
      end
    end
  end
end