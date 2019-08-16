module ApplicationHelper
  def error_messages_for(object)
    render "application/error_message", object: object
  end
  def present(object,klass= nil)
    klass ||="#{object.class}Presenter".constantize
    presenter=klass.new(object, self)
    yield presenter if block_given?
  end


end
