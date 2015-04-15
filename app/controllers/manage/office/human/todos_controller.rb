class Manage::Office::Human::TodosController < Manage::Office::Human::ApplicationController

    def index
        @todos = ::Office::Human::Todo.where(updater_id: @current_user.id).active.order(position: :desc)
    end

    def publish
        @todo = ::Office::Human::Todo.f(id)
        @todo.update_attributes(published: true)
        head @todo.valid? ? :accepted : :bad_request
    end

    def destroy
        @todo = ::Office::Human::Todo.f(id)
        @todo.update active: false
        redirect_to action: "index"
    end
end
