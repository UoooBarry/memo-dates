class EventsController < ApplicationController
  before_action :set_event, only: %i[show update destroy]

  # GET /events
  def index
    @events = Event.order_by_date_part
    @events = @events.map do |event|
      days_from_today = event.days_from_today
      event = event.as_json
      event['days_from_today'] = days_from_today
      event
    end

    render json: @events
  end

  # GET /events/1
  def show
    days_from_today = @event.days_from_today
    @event = @event.as_json
    @event['days_from_today'] = days_from_today
    render json: @event
  end

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      days_from_today = @event.days_from_today
      @event = @event.as_json
      @event['days_from_today'] = days_from_today
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      days_from_today = @event.days_from_today
      @event = @event.as_json
      @event['days_from_today'] = days_from_today
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.permit(:title, :description, :happen_date, :frequency, :layout, :photo)
  end
end
