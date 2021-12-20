class Contract < Sequel::Model

  def validate
    super
    errors.add(:legal, 'cannot be empty') if !legal || legal.empty?
    validates_date(start_date, end_date)
    overlap_date(start_date, end_date, legal)
  end

  def validates_date(start_date, end_date)
    if(!start_date.nil? && !end_date.nil?)
      errors.add(end_date, "End date should be greater than start date") if end_date < start_date
    end
  end

  def overlap_date(start_date, end_date, legal)
    
    if start_date.nil? && end_date.nil?
      contract = Contract.where(legal: legal).first
      errors.add(end_date, "#{start_date} ~ #{end_date} is overlap with #{contract.start_date} ~ #{contract.end_date}") if !contract.nil?
    elsif start_date.nil?
      contract = Contract.where(Sequel.lit('legal = ? AND (start_date is null OR end_date>=?)', legal, end_date)).first
      errors.add(end_date, "#{start_date} ~ #{end_date} is overlap with #{contract.start_date} ~ #{contract.end_date}") if !contract.nil?
    elsif end_date.nil?
      contract = Contract.where(Sequel.lit('legal = ? AND (end_date is null OR start_date<=?)', legal, start_date)).first
      errors.add(end_date, "#{start_date} ~ #{end_date} is overlap with #{contract.start_date} ~ #{contract.end_date}") if !contract.nil?
    else
      contract = Contract.where(Sequel.lit('legal = ? AND ((end_date is null OR start_date is null) OR ((start_date <= ?) and (end_date >= ? )))', legal, end_date, start_date)).first
      errors.add(end_date, "#{start_date} ~ #{end_date} is overlap with #{contract.start_date} ~ #{contract.end_date}") if !contract.nil?
    end

  end

  many_to_one :employee
  plugin :bitemporal, version_class: ContractVersion
end
