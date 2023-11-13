require 'rails_helper'

describe 'Usuário cadastra uma pousada' do
  it 'a partir da tela inicial' do
    user = User.create!(name: 'João', email: 'joao@email.com', password: '123456', role: :owner)

    login_as(user)
    visit root_path
    click_on 'Cadastrar Pousada'

    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Telefone'
    expect(page).to have_field 'E-mail'
    expect(page).to have_field 'Logradouro'
    expect(page).to have_field 'Bairro'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'CEP'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Política de Uso'
    expect(page).to have_field 'Aceita Pets'
    expect(page).to have_field 'Cartão de Crédito'
    expect(page).to have_field 'Pix'
  end

  it 'com sucesso' do
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: '123456', role: :owner)

    login_as(user)
    visit root_path
    click_on 'Cadastrar Pousada'
    fill_in 'Nome Fantasia', with: 'Vale Verde'
    fill_in 'Razão Social', with: 'Vale Verde LTDA'
    fill_in 'CNPJ', with: '64.955.882/0001-21'
    fill_in 'Telefone', with: '11-99877-6666'
    fill_in 'E-mail', with: 'valeverde@email.com'
    fill_in 'Logradouro', with: 'Rua da Praça, 10'
    fill_in 'Bairro', with: 'Carmo'
    fill_in 'Cidade', with: 'São Roque'
    select 'SP', from: 'Estado'
    fill_in 'CEP', with: '12328-665'
    fill_in 'Descrição', with: 'Pousada com muitas opções de lazer, natureza e ar puro'
    fill_in 'Política de Uso', with: 'Não é permitido fumar'
    check 'Aceita Pets'
    select '16', from: 'guesthouse_checkin_4i'
    select '00', from: 'guesthouse_checkin_5i'
    select '10', from: 'guesthouse_checkout_4i'
    select '15', from: 'guesthouse_checkout_5i'
    check 'Cartão de Crédito'
    check 'Pix'
    click_on 'Criar Pousada'

    expect(page).to have_content 'Pousada cadastrada com sucesso.'
    expect(page).to have_content 'Pousada Vale Verde'
    expect(page).to have_content 'Rua da Praça, 10 - Carmo, São Roque - SP'
    expect(page).to have_content 'Pousada com muitas opções de lazer, natureza e ar puro'
    expect(page).to have_content 'Não é permitido fumar'
    expect(page).to have_content 'Pets: Permitido'
    expect(page).to have_content '16:00'
    expect(page).to have_content '10:15'
  end

  it 'com dados incompletos' do
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: '123456', role: :owner)

    login_as(user)
    visit root_path
    click_on 'Cadastrar Pousada'
    click_on 'Criar Pousada'

    expect(page).to have_content 'Pousada não cadastrada.'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Telefone não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
  end
end