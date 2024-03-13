describe Customer do
  let(:email) { 'maggie.greene@twd.com' }

  describe '.validates' do
    it 'should not create customer without an email' do
      customer = Customer.create

      expect(customer.errors).to_not be_empty
      expect(customer.errors.messages[:email].first).to eql(I18n.t('activerecord.errors.models.customer.attributes.email.blank'))
    end

    it 'should not create customer with existent email' do
      Customer.create(email: email)
      customer = Customer.create(email: email)

      expect(customer.errors).to_not be_empty
      expect(customer.errors.messages[:email].first).to eql(I18n.t('activerecord.errors.models.customer.attributes.email.taken'))
    end

    it 'should not create customer with invalid email' do
      wrong_email = 'maggie.greene.twd.com'
      customer = Customer.create(email: wrong_email)

      expect(customer.errors).to_not be_empty
      expect(customer.errors.messages[:email].first).to eql(I18n.t('activerecord.errors.models.customer.attributes.email.invalid', value: wrong_email))
    end
  end
end