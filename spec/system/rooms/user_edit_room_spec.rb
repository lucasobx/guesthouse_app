require 'rails_helper'

describe 'Usuário edita um quarto' do
  it 'a partir da página de detalhes' do
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
    click_on 'Editar Suíte'

    expect(page).to have_content 'Editar Quarto'
    expect(page).to have_field 'Nome', with: 'Suíte'
    expect(page).to have_field 'Descrição', with: 'Suíte confortável com vista para a praia'
    expect(page).to have_field 'Tamanho', with: 40
    expect(page).to have_field 'Acomodação Máxima', with: 3
    expect(page).to have_field 'Valor da Diária', with: 150.0
    expect(page).to have_field 'Banheiro', checked: true
    expect(page).to have_field 'Varanda', checked: true
    expect(page).to have_field 'Ar Condicionado', checked: true
    expect(page).to have_field 'TV', checked: true
    expect(page).to have_field 'Guarda-Roupa', checked: true
    expect(page).to have_field 'Cofre', checked: true
    expect(page).to have_field 'Acessibilidade', checked: true
    expect(page).to have_field 'Disponível', checked: true
    expect(page).to have_button 'Atualizar Quarto'
  end

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
    click_on 'Editar Suíte'
    fill_in 'Nome', with: 'Suíte Luxo'
    uncheck 'Cofre'
    click_on 'Atualizar Quarto'

    expect(page).to have_content 'Quarto atualizado com sucesso'
    expect(page).to have_content 'Suíte Luxo'
    expect(page).to have_content 'Cofre: Não'
  end
end