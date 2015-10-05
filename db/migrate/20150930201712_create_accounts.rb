class CreateAccounts < ActiveRecord::Migration

  execute <<-SQL
  CREATE OR REPLACE VIEW accounts AS
    SELECT
     users.id 	       AS user_id,
     users.username    AS username,
     users.email       AS email,
     organizations.id  AS organization_id,
     applications.id 	 AS application_id,
     authorizations.id AS authorization_id

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
