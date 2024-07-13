class ApplicationController < ActionController::API
  def doorkeeper_unauthorized_render_options(error: nil)
    { 
      json: { 
        error: 'Not authorized', 
        message: 'You need to log in or provide a valid token.'
      }
    }
  end
end
