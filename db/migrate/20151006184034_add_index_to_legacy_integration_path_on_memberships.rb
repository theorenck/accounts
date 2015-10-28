class AddIndexToLegacyIntegrationPathOnMemberships < ActiveRecord::Migration
  def change
    execute <<-SQL
      CREATE INDEX membership_integration_index ON memberships ((integration->>'integration'))
    SQL
  end
end
