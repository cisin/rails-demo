# encoding: utf-8
class LinenItemsController < BaseController

  def autocomplete
    @linen_item = end_of_association_chain.ordered.search(params[:term]).limit(params[:limit] || 30)
    render :json => LinenItemPresenter.new(@linen_item)
  end

  def create
    create! do |success, failure|
      redirect_path(success)
    end
  end

  def update
    update! do |success, failure|
      redirect_path(success)
    end
  end

  protected

  def redirect_path(success)
    success.html do
      if redirect_to_url?
        redirect_to redirect_to_url
      else
        redirect_to new_resource_path
      end
    end
  end
end
