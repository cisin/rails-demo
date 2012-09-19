# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "LinenItem", %q{
  As an admin
  I want to manage the linen items
  In order to manage those who access the salus
} do

  background do
    authorize 'users'
    authorize 'linen_items'
    sign_in
  end

  scenario "I want to create a linen item" do
    visit search_linen_items_path

    click_link "Novo Linen item"

    fill_the_following   'Id'              => 1,
                         'Description'     => 'test',
                         'Weight'          => 100

    choose('Bath Linen Set')
    choose('Bath Rug')
    choose('White')
    choose('100% cotton')

    click_button 'Salvar Linen item'

    page.should have_content 'Linen item criado com sucesso.'
  end

  scenario "I want to edit a linen item" do
    create_linen_item

    visit search_linen_items_path

    fill_autocomplete 'search', :with => 'test', :select => 'test linen item'
    click_link 'Editar Linen item'

    fill_in 'Description', :with => 'Edit Test linen item'

    click_button 'Salvar Linen item'
    page.should have_content 'Linen item editado com sucesso.'
  end

  scenario "I want to delete linen item" do
    create_linen_item

    visit search_linen_items_path

    click_link 'Listagem de Linen item'
    page.should have_content 'Listagem de Linen item'

    click_link 'Apagar Linen item'
    confirm_dialog

    page.should have_content 'Linen item apagado com sucesso.'
  end

  def create_linen_item
    LinenItem.make!
  end
end
