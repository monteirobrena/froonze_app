describe SetFieldService do
  let(:set_field_service) { described_class }

  let(:first_name) { ' Rick ' }
  let(:customer) { Customer.create({ first_name: first_name }) }

  describe '#call' do
    context 'create customer without service' do
      it { expect(customer.first_name).to eq(first_name) }
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