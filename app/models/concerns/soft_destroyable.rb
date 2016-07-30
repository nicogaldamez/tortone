require 'active_support/concern'
module SoftDestroyable
  extend ActiveSupport::Concern

  included do
    def permanent_destroy?
      false
    end

    def soft_delete
      self.update!(deleted_at: Time.zone.now)
    end

    def destroy
      if permanent_destroy?
        super
      else
        soft_delete
      end
    end

  end

end
