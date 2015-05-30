Rails.application.routes.draw do

	root 'manage/homes#index'
	get 'login' => 'manage/sessions#new', as: :login
	get 'logout' => 'manage/registrations#destroy', as: :logout

	resources :homes

	namespace :user do
		root "sessions#new"
		resources :registrations
		resources :sessions do
			get :destroy, on: :member
		end
	end

	namespace :manage do
		root to: 'homes#index'

		resources :sessions, :accounts, :editors, :roles, :grants, :users, :posts

		resources :users do
			get :password, on: :member
			put :update_password, on: :member
		end

		namespace :office do
			namespace :human do
				resources :companies, :departments, :employees, :events, :todos, :dailies do
					put :publish, on: :member
					put :unpublish, on: :member
				end
				resources :dailies do
					get :download, on: :member
					put :publish, on: :member
					put :unpublish, on: :member
				end
				resources :redmines, only: [:index]
			end
		end
	end


end
