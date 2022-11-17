class ApplicationController < ActionController::Base
  include TranzitoUtils::SetPeriod

  helper_method :controller_namespace

  def controller_namespace
    @controller_namespace ||= (self.class.module_parent.name != "Object") ? self.class.module_parent.name.downcase : nil
  end
end
