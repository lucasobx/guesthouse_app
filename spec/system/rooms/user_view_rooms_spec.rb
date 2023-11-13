require 'rails_helper'

describe 'Usuário vê quartos' do
  it 'com sucesso' do
    user = User.create!(name: 'João', email: 'joao@email.com', password: '123456')
    guesthouse = Guesthouse.new(brand_name: 'Pousada da Praia', corporate_name: 'Pousada da Praia LTDA',
                                registration_number: '41522300', phone_number: '11985456877',
                                email: 'pousadapraia@email.com', description: 'Pousada do lado da praia',
                                pets: false, use_policy: 'Proibido receber visitas', checkin: '10:00',
                                checkout: '20:00', status: true)
    guesthouse.build_address(street: 'Rua da Pousada', neighborhood: 'Praça da Pousada',
                             city: 'São Roque', state: 'SP', postal_code: '10000-000')
    guesthouse.user = user
    guesthouse.save!
    guesthouse.rooms.create!(name: 'Suíte', description: 'Suíte confortável com vista para a praia', size: 40,
                             max_capacity: 3, daily_rate: 150, bathroom: true, balcony: true, air_conditioning: true,
                             tv: true, closet: true, safe: true, accessibility: true, status: true)

    login_as(user)
    visit root_path
    click_on 'Pousada da Praia'

    expect(page).to have_content 'Suíte'
    expect(page).to have_content 'Tamanho: 40m'
    expect(page).to have_content 'Acomodação Máxima: 3 Hóspedes'
    expect(page).to have_content 'Valor da Diária: R$ 150,00'
    expect(page).to have_content 'Banheiro: Sim'
    expect(page).to have_content 'Varanda: Sim'
    expect(page).to have_content 'Ar Condicionado: Sim'
    expect(page).to have_content 'TV: Sim'
    expect(page).to have_content 'Guarda-Roupa: Sim'
    expect(page).to have_content 'Cofre: Sim'
    expect(page).to have_content 'Acessibilidade: Sim'
    expect(page).to have_content 'Disponível: Sim'
  end
end