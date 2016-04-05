class Admin::BaseController < ApplicationController
  layout "admin/layouts/application.html.haml"
  before_action :authenticate_user!
end
