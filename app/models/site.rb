class Site < ActiveRecord::Base
  include GoogleSpreadsheets::Enhanced::Syncing
  sync_with :site_rows, spreadsheet_id: '0ArhV7gTgs6Z8dFNLVVVwdE1Kd3FLWWJXZlRweGdEcFE'
  after_commit :sync_site_row

  has_many :posts
end
