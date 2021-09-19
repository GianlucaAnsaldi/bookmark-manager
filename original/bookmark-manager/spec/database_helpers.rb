require 'pg'
require 'database_connection'

def persisted_data(table:, id:)
  connection = PG.connect(dbname: 'bookmark_manager_test')
  connection.query("SELECT * FROM #{table} WHERE id = '#{id}';")
  # DatabaseConnection.query(
  #   "SELECT * FROM #{table} WHERE id = $1;",
  #   [table, id]
  # )
end
