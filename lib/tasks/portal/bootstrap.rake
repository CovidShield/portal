desc "Bootstrap DB if necessary"
namespace :portal do
  task :bootstrap do
    if setup_required?
      Rake::Task['db:setup'].invoke
    end

    if migrate_required?
      Rake::Task['db:setup'].invoke
    end
  end

  def setup_required?
    begin
      ActiveRecord::Base.connection
      false
    rescue
      true
    end
  end

  def migrate_required?
    ActiveRecord::Base.connection.tables.include? User.table_name
  end
end
