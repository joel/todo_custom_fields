# frozen_string_literal: true

class ItemsController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :set_todo

  before_action :set_item, only: %i[destroy]

  # GET /items/new
  def new
    @item = @todo.items.new
    @todo.fields.each do |field|
      @item.field_associations.build(field:)
    end
  end

  # POST /items or /items.json
  def create
    @item = @todo.items.new(item_params)

    @collections = Collections.new(@todo)
    @filter      = Memoization.new(@todo, {})

    @filter.name ||= Obfuscator.new.encrypt({ name: @todo.items.first.name }.to_json) if @todo.items.any?

    respond_to do |format|
      if @item.save

        position = 0
        field_params.each do |key, value|
          @item.field_associations.create(
            field: @todo.fields.where(identifier: key).take,
            position: position += 1,
            value:
          )
        end

        format.html { redirect_to todo_item_url(@todo, @item), notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
        format.turbo_stream { flash.now[:notice] = "Item was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to todo_items_url(@todo), notice: "Item was successfully destroyed." }
      format.json { head :no_content }
      format.turbo_stream do
        flash.now[:notice] = "Item was successfully destroyed."
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = @todo.items.find(params[:id])
  end

  def set_todo
    @todo = Todo.find(params[:todo_id])
  end

  # Only allow a list of trusted parameters through.
  def item_params
    params.require(:item).permit(:name, field_associations_attributes: %i[id field_id value _destroy])
  end

  def field_params
    params.require(:fields).permit(*@todo.fields.pluck(:name).map(&:downcase).map(&:to_sym))
  rescue ActionController::ParameterMissing
    {}
  end
end
