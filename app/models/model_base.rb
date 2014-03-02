# -*- encoding : utf-8 -*-
module ModelBase

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    def all_by_user_session(user, order='created_at DESC')
      self.where(:user_id => user).order(order)
    end


  end

end
