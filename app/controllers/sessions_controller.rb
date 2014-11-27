class SessionsController < Devise::SessionsController
  respond_to :html, :json

  def create
    resource = warden.authenticate!(scope: resource_name, recall: 'sessions#failure')
    sign_in_and_redirect(resource_name, resource)
  end

  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource

    respond_to do |format|
      format.html do
        redirect_to stored_location_for(scope) || after_sign_in_path_for(resource)
      end

      format.json do
        render json: { success: resource } and return
      end
    end
  end

  def failure
    respond_to do |format|
      format.html do
        redirect_to new_user_session_path
      end

      format.json do
        render json: { success: false, errors: 'Login failed.' } and return
      end
    end
  end
end
