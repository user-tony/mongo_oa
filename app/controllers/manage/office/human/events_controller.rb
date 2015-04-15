class Manage::Office::Human::EventsController < Manage::Office::Human::ApplicationController
    def index
        @events = ::Office::Human::Event.active
        @records = @events.where(user_id: @current_user.id, published: true).map do |event|
            {
                id: event.id,
                title: event.title,
                description: event.description,
                start: event.start_time.try(:to_s, :db),
                end: (event.end_time || event.start_time).try(:to_s, :db),
                allDay: false,
                className: ["event", "bg-color-#{event.color}"],
                icon: 'fa-clock-o'
            }
        end
        respond_to do |format|
            format.html
            format.json { render json: @records.to_json }
        end
    end

    def create
        @event = ::Office::Human::Event.new(params[:event].permit(:title, :description, :genre, :color, :start_time, :end_time).merge(user_id: @current_user.id))

        respond_to do |format|
            if @event.save
                format.html
                format.json { render json: @event.to_json }
            else
                format.html
                format.json { render json: { errors: @event.errors.full_messages } }
            end
        end
    end

    def publish
        @event = ::Office::Human::Event.f(id)
        @event.update_attributes(published: true, start_time: params[:start_time], end_time: params[:end_time])
        head @event.valid? ? :accepted : :bad_request
    end

    def destroy
        @event = ::Office::Human::Event.f(id)
        @event.update active: false
        redirect_to action: "index"
    end
end
