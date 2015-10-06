class AddIndexToLegacyIntegrationPathOnMemberships < ActiveRecord::Migration
  def change
    execute <<-SQL
      CREATE INDEX membership_legacy_integration_index ON memberships ((legacy_integration->>'integration'))
    SQL
  end
end
