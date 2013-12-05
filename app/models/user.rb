# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  has_soft_deletion default_scope: true

  attr_accessible :name, :login , :password, :email,
                  :access_number, :last_access_at, :last_access_ip,
                  :password_recovery_at, :password_recovery_hash, :deleted_at

  has_many :projects
  has_many :time_works

  validates_presence_of :name, :login, :password, :email

  validate :email_valid?, :set_password_to_md5

  private

  def set_password_to_md5
    self.password = Digest::MD5.hexdigest password
  end

  def email_valid?
    errors.add(:email, 'Email inválido') if email_invalid? email
  end

  # Retorna true caso o email seja inválido
  def email_invalid?(email)
    unless email =~ /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]+\z/i
      return true
    end unless email.empty?
  end

end
