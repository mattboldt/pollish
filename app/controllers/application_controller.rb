class ApplicationController < ActionController::Base
  def current_host
    @current_host ||= if (id = cookies[:host_id]).present?
      if (existing_host = Host.find_by(id: id)).present?
        existing_host
      else
        cookies.delete :host_id
        create_new_host
      end
    else
      create_new_host
    end
  end

  private

  def create_new_host
    new_host = Host.create
    cookies[:host_id] = new_host.id

    new_host
  end
end
