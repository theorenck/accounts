class CreateAccounts < ActiveRecord::Migration

  execute <<-SQL
  CREATE OR REPLACE VIEW accounts AS
    SELECT
     users.username 	       AS user_username,
     users.email 	           AS user_email,
     organizations.name 	   AS organization_name,
     memberships.authorized  AS membership_authorized,
     applications.name 	     AS application_name,
     applications.redirect_uri AS application_redirect_uri,
     applications.version      AS application_version,
     authorizations.revoked_at AS authorization_revoked_at

    FROM
     users,
     organizations,
     memberships,
     authorizations,
     applications

    WHERE
     (
       memberships.user_id = users.id
       AND
       memberships.organization_id = organizations.id
     )
     AND
     (
       authorizations.application_id = applications.id
       AND
       authorizations.membership_id = memberships.id
     )
   SQL

end
