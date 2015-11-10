require 'rails_helper'

describe PeopleController, type: :controller do

  context 'without a signed in user' do
    describe 'GET #index' do
      it 'should redirect to the sign in page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'with a signed in user' do
    login_user

    describe 'GET #index' do
      it 'should render the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  context 'with a signed in admin user' do
    login_admin

    describe 'Get #index' do
      it 'should render the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end
  end



end