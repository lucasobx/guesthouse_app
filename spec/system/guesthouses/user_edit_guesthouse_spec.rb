require 'rails_helper'

describe 'Usuário edita uma pousada' do
  it 'a partir da página de detalhes' do
    guesthouse = Guesthouse.new(brand_name: 'Pousada da Praia', corporate_name: 'Pousada da Praia LTDA',
                                registration_number: '41522300', phone_number: '11985456877',
                                email: 'pousadapraia@email.com', description: 'Descrição', pets: false,
                                use_policy: 'Proibido receber visitas', checkin: '10:00',
                                checkout: '20:00', status: true)
    guesthouse.build_address(street: 'Rua da Pousada', neighborhood: 'Praça da Pousada',
                             city: 'São Roque', state: 'SP', postal_code: '10000-000')
    guesthouse.save!
    
    visit root_path
    click_on 'Pousada da Praia'
    click_on 'Editar Pousada'

    expect(page).to have_content 'Editar Pousada'
    expect(page).to have_field 'Nome Fantasia', with: 'Pousada da Praia'
    expect(page).to have_field 'Razão Social', with: 'Pousada da Praia LTDA'
    expect(page).to have_field 'CNPJ', with: '41522300'
    expect(page).to have_field 'Telefone', with: '11985456877'
    expect(page).to have_field 'E-mail', with: 'pousadapraia@email.com'
    expect(page).to have_field 'Logradouro', with: 'Rua da Pousada'
    expect(page).to have_field 'Bairro', with: 'Praça da Pousada'
    expect(page).to have_field 'Cidade', with: 'São Roque'
    expect(page).to have_select 'Estado', with_options: ['SP']
    expect(page).to have_field 'CEP', with: '10000-000'
    expect(page).to have_field 'Descrição', with: 'Descrição'
    expect(page).to have_field 'Aceita Pets', type: 'checkbox', checked: false
    expect(page).to have_field 'Política de Uso', with: 'Proibido receber visitas'
    expect(page).to have_select 'guesthouse_checkin_4i', with_options: ['10']
    expect(page).to have_select 'guesthouse_checkin_5i', with_options: ['00']
    expect(page).to have_select 'guesthouse_checkout_4i', with_options: ['20']
    expect(page).to have_select 'guesthouse_checkout_5i', with_options: ['00']
  end

  it 'com sucesso' do
    guesthouse = Guesthouse.new(brand_name: 'Pousada da Praia', corporate_name: 'Pousada da Praia LTDA',
                                registration_number: '41522300', phone_number: '11985456877',
                                email: 'pousadapraia@email.com', description: 'Descrição', pets: false,
                                use_policy: 'Proibido receber visitas', checkin: '10:00',
                                checkout: '20:00', status: true)
    guesthouse.build_address(street: 'Rua da Pousada', neighborhood: 'Praça da Pousada',
                             city: 'São Roque', state: 'SP', postal_code: '10000-000')
    guesthouse.save!
    
    visit root_path
    click_on 'Pousada da Praia'
    click_on 'Editar Pousada'
    fill_in 'Política de Uso', with: 'Proibido receber visitas e fumar'
    click_on 'Atualizar Pousada'

    expect(page).to have_content 'Pousada atualizada com sucesso.'
    expect(page).to have_content 'Política de Uso: Proibido receber visitas e fumar'
  end

  it 'e mantém os campos obrigatórios' do
    guesthouse = Guesthouse.new(brand_name: 'Pousada da Praia', corporate_name: 'Pousada da Praia LTDA',
                                registration_number: '41522300', phone_number: '11985456877',
                                email: 'pousadapraia@email.com', description: 'Descrição', pets: false,
                                use_policy: 'Proibido receber visitas', checkin: '10:00',
                                checkout: '20:00', status: true)
    guesthouse.build_address(street: 'Rua da Pousada', neighborhood: 'Praça da Pousada',
                             city: 'São Roque', state: 'SP', postal_code: '10000-000')
    guesthouse.save!

    visit root_path
    click_on 'Pousada da Praia'
    click_on 'Editar Pousada'
    fill_in 'Nome Fantasia', with: ''
    fill_in 'CNPJ', with: ''
    click_on 'Atualizar Pousada'

    expect(page).to have_content 'Não foi possível atualizar a pousada'
  end
end
