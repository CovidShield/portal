desc "Bootstrap DB if necessary"
namespace :portal do
  task :bootstrap do
    Rake::Task['environment'].invoke

    Rake::Task['db:setup'].invoke if setup_required?
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke unless User.exists?(username: 'admin@covidshield.app')
  end

  def setup_required?
    begin
      ActiveRecord::Base.connection
      false
    rescue
      true
    end
  end
end
