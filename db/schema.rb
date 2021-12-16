Sequel.migration do
  change do
    create_table(:contract_versions) do
      primary_key :id, :type=>"INTEGER"
      column :master_id, "Interger"
      column :valid_from, "date"
      column :valid_to, "date"
      column :created_at, "date"
      column :expired_at, "date"
    end
    
    create_table(:contracts) do
      primary_key :id, :type=>"INTEGER"
      column :start_date, "date"
      column :end_date, "date"
      column :legal, "varchar(255)"
    end
    
    create_table(:employee_versions) do
      primary_key :id, :type=>"INTEGER"
      column :master_id, "INTEGER"
      column :valid_from, "date"
      column :valid_to, "date"
      column :created_at, "date"
      column :expired_at, "date"
    end
    
    create_table(:employees) do
      primary_key :id, :type=>"INTEGER"
      column :first_name, "varchar(255)"
      column :last_name, "varchar(255)"
      column :birth_date, "date"
      column :address, "TEXT"
    end
    
    create_table(:schema_migrations) do
      column :filename, "varchar(255)", :null=>false
      
      primary_key [:filename]
    end
  end
end
              Sequel.migration do
                change do
                  self << "INSERT INTO `schema_migrations` (`filename`) VALUES ('20211216011203_create_employees.rb')"
self << "INSERT INTO `schema_migrations` (`filename`) VALUES ('20211216011212_create_contracts.rb')"
self << "INSERT INTO `schema_migrations` (`filename`) VALUES ('20211216011317_create_employee_versions.rb')"
self << "INSERT INTO `schema_migrations` (`filename`) VALUES ('20211216011329_create_contract_versions.rb')"
                end
              end
