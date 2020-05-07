class AdminMailer < ApplicationMailer
  default from: 'firefly@thalesinflight.com'

  def version_change(new_version:)
    @new_version = new_version
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
  	data = File.read("CHANGELOG.md")
  	@changelog = markdown.render(data).html_safe

    mail(to: "chris.swann@thalesinflight.com, Akhil.METTU@us.thalesgroup.com, Allan.Man@us.thalesgroup.com, waiman.jung@us.thalesgroup.com, maaz.siddiqui@thalesinflight.com, naval.sodha@lexonet.com, veda.ramaiah@us.thalesgroup.com, Andronico.CASTELLANOS@us.thalesgroup.com, mehdi.benmessaoud@us.thalesgroup.com, Stephane.TOUSSAINT@us.thalesgroup.com", subject: "Firefly has been upgraded to version #{new_version}")
  end

  def test
    mail(to: "chris.swann@thalesinflight.com",
         subject: 'Email System Test') do |format|
      format.text { render plain: 'Email system test from Firefly' }
    end
  end

end
