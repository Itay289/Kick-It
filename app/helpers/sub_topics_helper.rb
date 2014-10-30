module SubTopicsHelper
  def show_name(subject)
    subject.created_by.to_s.split('@').first
  end
end

