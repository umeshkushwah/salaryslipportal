class Organization < ActiveRecord::Base
  validates :name, :address, :domain, :city, :state, :pin_code, presence: true
  validates :phone, presence: true, numericality: true, length: {minimum: 10, maximum: 11} 
  has_many :employees
  mount_uploader :logo, LogoUploader
end
