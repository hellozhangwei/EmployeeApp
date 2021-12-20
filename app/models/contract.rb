class Contract < Sequel::Model


def validate
  super
  validates_date(start_date, end_date)
end

def validates_date(start_date, end_date)
  if(!start_date.nil? && !end_date.nil?)
    errors.add(end_date, "End date should be greater than start date") if end_date < start_date
  end

end

  many_to_one :employee
  plugin :bitemporal, version_class: ContractVersion
end
