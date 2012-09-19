class BaseController < ApplicationController
  respond_to :js

  inherit_resources
  custom_actions :collection => %w(search autocomplete)

  #before_filter :authorize_controller!, :only => %w(search index show new create edit update destroy)

  def autocomplete
    render :json => end_of_association_chain.ordered.search(params[:term]).limit(params[:limit] || 10).to_autocomplete
  end

  def create
    create! do |success, failure|
      success.html do
        if redirect_to_url?
          redirect_to redirect_to_url
        else
          redirect_to collection_path
        end
      end
    end
  end

  def update
    update! do |success, failure|
      success.html do
        if redirect_to_url?
          redirect_to redirect_to_url
        else
          redirect_to collection_path
        end
      end
    end
  end

  protected

  def collection
    get_collection_ivar || set_collection_ivar(end_of_association_chain.ordered.paginate(:per_page => 8, :page => params[:page]))
  end

  def search_path(*args)
    search_resources_path(*args)
  end

  helper_method :search_path

  def autocomplete_path(*args)
    autocomplete_resources_path(*args)
  end

  helper_method :autocomplete_path

  def authorize_controller!
    authorize! action_name.to_sym, full_controller_name
  end

  def redirect_to_url
    params[:redirect_to].gsub("%3A#{resource_instance_name}_id", "#{resource.to_param}")
  end

  def redirect_to_url?
    params[:redirect_to].present?
  end

  def cancel_to_url
    if cancel_to_url?
      params[:cancel_to]
    else
      collection_path
    end
  end

  helper_method :cancel_to_url

  def cancel_to_url?
    params[:cancel_to].present?
  end
end
