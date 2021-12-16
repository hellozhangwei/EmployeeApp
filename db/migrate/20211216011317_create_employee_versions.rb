Sequel.migration do
  change do

    create_table :employee_versions do
      primary_key :id
      Integer :master_id
      Date :valid_from
      Date :valid_to
      Date :created_at
      Date :expired_at
    end

  end
end
