describe SetFieldService do
  let(:set_field_service) { described_class }

  let(:first_name) { ' Rick ' }
  let(:last_name)  { ' Grimes  ' }
  let(:phone)      { '+55 33 991 027 150' }
  let(:title)      { " The Ones Who Live " }
  let(:role)       { " Former sheriff's deputy " }
  let(:score)      { "100" }
  let(:email)      { 'rick.grimes@twd.com' }
  let(:customer)   { Customer.build({ first_name: first_name, email: email }) }

  describe '#call' do
    it 'should change the first_name' do
      call_result = set_field_service.new.call(
        customer: customer,
        field_name: 'first_name',
        new_value: first_name
      )
      expect(call_result).to eql({})
      expect(customer.first_name).to eq(first_name.strip)
    end

    it 'should change the last_name' do
      call_result = set_field_service.new.call(
        customer: customer,
        field_name: 'last_name',
        new_value: last_name
      )
      expect(call_result).to eql({})
      expect(customer.last_name).to eq(last_name.strip)
    end

    it 'should change the phone' do
      call_result = set_field_service.new.call(
        customer: customer,
        field_name: 'phone',
        new_value: phone
      )
      expect(call_result).to eql({})
      expect(customer.phone).to eq(phone.strip)
    end

    it 'should change the title' do
      call_result = set_field_service.new.call(
        customer: customer,
        field_name: 'title',
        new_value: title
      )
      expect(call_result).to eql({})
      expect(customer.title).to eq(title.strip)
    end

    it 'should change the role' do
      call_result = set_field_service.new.call(
        customer: customer,
        field_name: 'role',
        new_value: role
      )
      expect(call_result).to eql({})
      expect(customer.role).to eq(role.strip)
    end

    it 'should change the score' do
      call_result = set_field_service.new.call(
        customer: customer,
        field_name: 'score',
        new_value: score
      )
      expect(call_result).to eql({})
      expect(customer.score).to eq(score.to_i)
    end
  end
end