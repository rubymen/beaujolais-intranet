class SessionsController < Devise::SessionsController
  respond_to :html, :json
  def new
    if request.format.to_s == 'application/json'
      if current_user.nil?
        respond_to do |format|
          format.json do
            render json: {  }, status: 401 and return
          end
        end
      end
    end
    super
  end

  def create
    cookies[:login_attempts] ||= 0

    if params[:user][:email].blank? || params[:user][:password].blank?
      cookies[:login_attempts] = cookies[:login_attempts].to_i + 1
    end

    if verify_recaptcha
      cookies[:login_attempts] = 0
      resource = warden.authenticate!(scope: resource_name, recall: 'sessions#failure')
      sign_in_and_redirect(resource_name, resource)
    else
      redirect_to new_user_session_path
    end
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
        render json: {  }, status: 401 and return
      end
    end
  end
end
