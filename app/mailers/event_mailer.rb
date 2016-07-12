class EventMailer < ApplicationMailer

  def attendance_confirmation(user, event)
    @greeting = "Hi #{user.first_name}"
    @event = event
    mail to: user.email, subject: @event.title.to_s
  end

  def event_notice(event, manager, user)
    @event = event
    @manager = manager
    @user = @event.manager_profile.user
    mail(to: user.email, subject: "Few days to the #{event.title} event ")
  end
end
