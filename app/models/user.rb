# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  has_soft_deletion default_scope: true

  attr_accessible :name, :login , :password, :email, :password_confirmation,
                  :access_number, :last_access_at, :last_access_ip,
                  :password_recovery_at, :password_recovery_hash, :deleted_at

  has_many :projects
  has_many :time_works

  validates_presence_of :name, :login, :password, :email
  validates_uniqueness_of :login, :email

  validates_confirmation_of :password

  validate :email_valid?

  def self.user_by_login_and_password(user)
    password = self.generate_md5 user.password
    user     = User.where(login: user.login, password: password).limit(1)

    return user[0]
  end

  def self.generate_md5(string)
    return Digest::MD5.hexdigest string
  end

  def update_attributes_to_login
    self.access_number += 1

    self.update_attributes(:access_number  => self.access_number,
                           :last_access_ip => self.last_access_ip,
                           :last_access_at => Time.new)

    return self
  end

  def verify_inputs_to_login
    inputs_empty = false

    if login.empty?
      inputs_empty = true
      errors.add(:login, 'Obrigatório')
      end
    if password.empty?
      inputs_empty = true
      errors.add(:password, 'Obrigatório')
    end

    return inputs_empty
  end

  private

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
