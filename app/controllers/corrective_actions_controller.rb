class CorrectiveActionsController < ApplicationController
  include ActivityScoped
  authorize_resource class: false

  layout false, only: [:consumable_products, :consumable_batches, :rotable_part_off, :rotable_part_on, :rotable_serial_on]
  layout "activity"

  before_action :set_activity
  before_action :set_fault
  before_action :set_corrective_action, only: [:show, :edit, :update, :destroy]
  before_action :add_replacement_category, :change_removed_stock_item_serial_to_id, only: [:create, :update]

  def index
    @corrective_actions = @fault.corrective_actions
  end

  def show
  end

  def new
    @corrective_action = CorrectiveAction.new
    @corrective_action.build_replacement
  end

  def edit
    @corrective_action.replacement ||= @corrective_action.build_replacement
  end

  def create
    @corrective_action = @fault.corrective_actions.new(corrective_action_params.merge(activity: @activity))

    respond_to do |format|
      if @corrective_action.save
        format.html { redirect_to edit_activity_fault_resolutions_path(fault_id: @corrective_action.fault_id) }
        format.json { render :show, status: :created, location: [@activity, @corrective_action] }
      else
        format.html { render :new }
        format.json { render json: @corrective_action.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @corrective_action.update(corrective_action_params)
        format.html { redirect_to edit_activity_fault_resolutions_path(fault_id: @corrective_action.fault_id) }
        format.json { render :show, status: :ok, location: [@activity, @corrective_action] }
      else
        format.html { render :edit }
        format.json { render json: @corrective_action.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    fault = @corrective_action.fault
    respond_to do |format|
      if can_destroy? && @corrective_action.destroy
        format.html { redirect_to [@activity, fault] }
        format.json { head :no_content }
      else
        format.html { redirect_to [@activity, @corrective_action.fault], notice: "Corrective Action can only be destroyed within its originating activity and before workpack close." }
        format.json { render json: { error: "Corrective Action can only be destroyed within its originating activity and before workpack close.", status: :unprocessable_entity }, status: :unprocessable_entity }
      end
    end
  end

  # ============= CONSUMABLES AJAX ===============

  def consumable_products
    @consumable_products = @activity.aircraft.bill_of_materials.consumables.order_by_part_number
    render partial: 'options_for_select', locals: {data: @consumable_products, key: 'part_number', value: 'id', blank_label: '-- Select Part Number --'}
  end

  def consumable_batches
    @consumable_batches = StockItem.at_station(@activity.station).for_product(params[:product_id]).available_in_stock.is_serviceable.order_by_batch_number
    render partial: 'options_for_select', locals: {data: @consumable_batches, key: 'batch_number', value: 'id', blank_label: '-- Select Batch Number --'}
  end

  def consumable_install_quantity
    @quantity_installed = StockItem.find(params[:stock_item_id]).quantity
    render json: @quantity_installed
  end

  # ============= ROTABLES AJAX ===============

  def rotable_part_off
    @rotable_part_off = @activity.aircraft.bill_of_materials.rotables.order_by_part_number
    render partial: 'options_for_select', locals: {data: @rotable_part_off, key: 'part_number', value: 'id', blank_label: '-- Select Part Number --'}
  end

  def rotable_part_on
    selected_product_category = Product.find(params[:product_id]).product_category
    @rotable_part_on = @activity.aircraft.bill_of_materials.having_same_product_category_of(selected_product_category).rotables.order_by_part_number
    render partial: 'options_for_select', locals: {data: @rotable_part_on, key: 'part_number', value: 'id', blank_label: '-- Select Part Number --'}
  end

  def rotable_serial_on
    @rotable_serial_on = StockItem.at_station(@activity.station).for_product(params[:product_id]).available_in_stock.is_serviceable.order_by_serial_number
    render partial: 'options_for_select', locals: {data: @rotable_serial_on, key: 'serial_number', value: 'id', blank_label: '-- Select Serial Number --'}
  end

  private

    def set_corrective_action
      @corrective_action = CorrectiveAction.find(params[:id])
    end

    def set_fault
      @fault = Fault.find(params[:fault_id])
    end

    def corrective_action_params
      params.require(:corrective_action).permit(:fault_id, :job_started_at, :performed_by_id, :logbook_reference, :maintenance_action_id, :logbook_text, :document_reference, :batch_quantity, replacement_attributes: [:id, :on_wing_position, :installed_stock_item_id, :removed_stock_item_id, :installed_product_id, :removed_product_id, :removed_revision, :install_quantity, :category, :removed_model_numbers => []])
    end

    def change_removed_stock_item_serial_to_id
      serial_off = params.dig(:corrective_action, :replacement_attributes, :removed_stock_item_id)
      removed_stock_item = StockItem.find_by_serial_number(serial_off.upcase).try(:id) if serial_off.present?
      params[:corrective_action][:replacement_attributes][:removed_stock_item_id] = removed_stock_item if removed_stock_item.present?
    end

    def add_replacement_category
      if params.dig(:corrective_action, :replacement_attributes)
        installed_product = Product.find_by_id(params.dig(:corrective_action, :replacement_attributes, :installed_product_id))
        params[:corrective_action][:replacement_attributes].merge!(category: installed_product.product_category.product_type.downcase) if installed_product.present?
      end
    end

    def can_destroy?
      ['complete', 'error'].exclude?(@activity.state) && @corrective_action.activity == @activity
    end

end
