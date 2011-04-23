class Event < ActiveRecord::Base

	 belongs_to :flyer
	 has_one :upcoming_event
	 has_one :event_request
  has_many :gallery

  def event_notes_styles(index)
    styles = {:bold => false, :italics => false}
    ens = self.send("event_notes#{index}_styles")
    if ens
      styles[:bold] = true if ens.match('bold')
      styles[:italics] = true if ens.match('italics')
    end
    styles
  end

  def translate_to_css(notes)
    css = ""
    ens = self.send("event_notes#{notes}_styles")
    if ens
      css << "font-weight:bold;" if ens.match('bold')
      css << "font-style:italic;" if ens.match('italics')
    end
    css
  end
end
