class Admin::BaseController < ApplicationController
  layout "admin/layouts/application"
  before_action :authenticate_user!
end
