class AddPreferredCompensationFieldsToDevelopers < ActiveRecord::Migration[7.0]
  def change
    # TEMP: Comment out migration to sync with production version.
    # add_column :developers, :preferred_min_hourly_rate, :integer
    # add_column :developers, :preferred_max_hourly_rate, :integer
    # add_column :developers, :preferred_min_salary, :integer
    # add_column :developers, :preferred_max_salary, :integer
  end
end
