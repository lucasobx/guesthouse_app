require 'rails_helper'

describe 'Usuário cadastra quarto' do
  it 'com sucesso' do
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: '123456', role: :owner)
    guesthouse = Guesthouse.new(brand_name: 'Pousada da Praia', corporate_name: 'Pousada da Praia LTDA',
                                registration_number: '41522300', phone_number: '11985456877',
                                email: 'pousadapraia@email.com', description: 'Descrição', pets: false,
                                use_policy: 'Proibido receber visitas', checkin: '10:00',
                                checkout: '20:00', status: true)
    guesthouse.build_address(street: 'Rua da Pousada', neighborhood: 'Praça da Pousada',
                             city: 'São Roque', state: 'SP', postal_code: '10000-000')

    guesthouse.user = user
    guesthouse.save!

    login_as(user)
    visit root_path
    click_on 'Pousada da Praia'
    click_on 'Cadastrar Quarto'

    fill_in 'Nome', with: 'Suíte'
    fill_in 'Descrição', with: 'Suíte espaçosa com vista para a praia'
    fill_in 'Tamanho', with: 20
    fill_in 'Acomodação Máxima', with: 2
    fill_in 'Valor da Diária', with: 80
    check 'Banheiro'
    check 'Varanda'
    check 'Ar Condicionado'
    check 'TV'
    check 'Guarda-Roupa'
    check 'Cofre'
    check 'Acessibilidade'
    check 'Disponível'
    click_on 'Criar Quarto'

    created_room = Room.last
    expect(current_path).to eq guesthouse_room_path(guesthouse, created_room)
    expect(page).to have_content 'Suíte'
    expect(page).to have_content 'Suíte espaçosa com vista para a praia'
    expect(page).to have_content 'Tamanho: 20m'
    expect(page).to have_content 'Acomodação Máxima: 2 Hóspedes'
    expect(page).to have_content 'Valor da Diária: R$ 80,00'
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