require 'rails_helper'

RSpec.describe Guesthouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'falso quando Nome Fantasia está vazio' do
        guesthouse = Guesthouse.new(brand_name: '', corporate_name: 'Pousada LTDA',
                                    registration_number: '41522300', phone_number: '11985456877',
                                    email: 'pousada@email.com', description: 'Descrição', pets: false,
                                    use_policy: 'Proibido receber visitas', checkin: '10:00',
                                    checkout: '20:00', status: true)

        result = guesthouse.valid?

        expect(result).to eq false
      end

      it 'falso quando Razão Social está vazio' do
        guesthouse = Guesthouse.new(brand_name: 'Pousada', corporate_name: '',
                                    registration_number: '41522300', phone_number: '11985456877',
                                    email: 'pousada@email.com', description: 'Descrição', pets: false,
                                    use_policy: 'Proibido receber visitas', checkin: '10:00',
                                    checkout: '20:00', status: true)

        result = guesthouse.valid?

        expect(result).to eq false
      end

      it 'falso quando CNPJ está vazio' do
        guesthouse = Guesthouse.new(brand_name: 'Pousada', corporate_name: 'Pousada LTDA',
                                    registration_number: '', phone_number: '11985456877',
                                    email: 'pousada@email.com', description: 'Descrição', pets: false,
                                    use_policy: 'Proibido receber visitas', checkin: '10:00',
                                    checkout: '20:00', status: true)

        result = guesthouse.valid?

        expect(result).to eq false
      end

      it 'falso quando Telefone está vazio' do
        guesthouse = Guesthouse.new(brand_name: 'Pousada', corporate_name: 'Pousada LTDA',
                                    registration_number: '41522300', phone_number: '',
                                    email: 'pousada@email.com', description: 'Descrição', pets: false,
                                    use_policy: 'Proibido receber visitas', checkin: '10:00',
                                    checkout: '20:00', status: true)

        result = guesthouse.valid?

        expect(result).to eq false
      end

      it 'falso quando E-mail está vazio' do
        guesthouse = Guesthouse.new(brand_name: 'Pousada', corporate_name: 'Pousada LTDA',
                                    registration_number: '41522300', phone_number: '11985456877',
                                    email: '', description: 'Descrição', pets: false,
                                    use_policy: 'Proibido receber visitas', checkin: '10:00',
                                    checkout: '20:00', status: true)

        result = guesthouse.valid?

        expect(result).to eq false
      end
    end
  end
end