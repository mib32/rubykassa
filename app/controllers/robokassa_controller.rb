# -*- encoding : utf-8 -*-
class RobokassaController < ApplicationController
  before_filter :create_notification

  def paid
    if @notification.valid_result_signature?
      result_callback @notification
    else
      fail_callback @notification
    end
  end

  def success
    if @notification.valid_success_signature?
      success_callback @notification
    else
      fail_callback @notification
    end
  end

  def fail
    fail_callback @notification
  end

  private

    def create_notification
      if request.get?
        @notification = Rubykassa::Notification.new request.query_parameters
      elsif request.post?
        @notification = Rubykassa::Notification.new request.request_parameters
      end
    end
end
