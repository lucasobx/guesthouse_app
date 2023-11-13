require 'rails_helper'

describe 'Usuário registra um preço por período' do
  it 'com sucesso' do
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: '123456', role: :owner)
    guesthouse = Guesthouse.new(brand_name: 'Pousada da Praia', corporate_name: 'Pousada da Praia LTDA',
                                registration_number: '41522300', phone_number: '11985456877',
                                email: 'pousadapraia@email.com', description: 'Descrição', pets: false,
                                use_policy: 'Proibido receber visitas', checkin: '10:00',
                                checkout: '20:00', status: true, payment_method: ['credit_card', 'pix'])
    guesthouse.build_address(street: 'Rua da Pousada', neighborhood: 'Praça da Pousada',
                             city: 'São Roque', state: 'SP', postal_code: '10000-000')

    guesthouse.user = user
    guesthouse.save!
    guesthouse.rooms.create!([{ name: 'Suíte', description: 'Suíte espaçosa', size: 50,
                                max_capacity: 3, daily_rate: 150, bathroom: true, balcony: true,
                                air_conditioning: true, tv: true, closet: true, safe: true, accessibility: true,
                                status: true },
                              { name: 'Quarto Pequeno', description: 'Quarto pequeno e confortável', size: 20,
                                max_capacity: 1, daily_rate: 60, bathroom: true, balcony: false,
                                air_conditioning: true, tv: true, closet: true, safe: false, accessibility: true,
                                status: true }])
    
    login_as(user)
    visit root_path
    click_on 'Pousada da Praia'
    # click_on 'Gerenciar Preços por Período'

    # fill_in 'Data de Início', with: '2023-12-01'
    # fill_in 'Data de Fim', with: '2024-02-29'
    # fill_in 'Preço Diário', with: '400'
    # click_on 'Salvar Preço por Período'

    # expect(page).to have_content 'Preço por período cadastrado com sucesso.'
    # expect(page).to have_content '2023-12-01 até 2024-02-29: R$400,00'
  end
end