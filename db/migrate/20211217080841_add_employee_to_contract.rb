# frozen_string_literal: true

Sequel.migration do
  change do
    alter_table :contracts do
      # add_column :employee, References
      add_foreign_key :employee_id, :employees
    end
  end
end
