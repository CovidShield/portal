desc "Bootstrap DB if necessary"
namespace :portal do
  task :bootstrap do
    Rake::Task['environment'].invoke

    full_setup = setup_required?

    Rake::Task['db:setup'].invoke if full_setup
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke if full_setup
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
