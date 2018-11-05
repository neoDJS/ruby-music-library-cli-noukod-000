require 'bundler'
Bundler.require

module Concerns
  module ClassMethods
    def destroy_all
      self.all.clear
    end

    def create(name="")
      asg = self.new(name)
      asg.save
      asg
    end

    def count
      self.all.count
    end
  end

  module InstanceMethods
    def save
      self.class.all << self #if self.class.find_by_name(self.name).nil?
    end
  end

  module Findable
    def find_by_name(name)
      self.all.detect{|a| a.name == name}
    end

    def find_or_new_by_name(name)
      e = find_by_name(name)
      if e.nil?
        e = self.new(name)
      end
      e
    end

    def find_or_create_by_name(name)
      e = find_by_name(name)
      if e.nil?
        e = self.create(name)
      end
      e
    end
  end
end

require_all 'lib'
