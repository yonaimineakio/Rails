class ApplicationController < ActionController::Base

  def hello
    render html: "Ora mundo!"
  end

  def goodbye
    render html: "goodbye"
  end
end
