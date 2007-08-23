module PluginAWeek #:nodoc:
  module CoreExtensions #:nodoc:
    module Module #:nodoc:
      module ModuleCreationHelper
        # Creates a new module with the specified name.  This is essentially the
        # same as actually defining the module like so:
        # 
        #   module NewModule
        #   end
        # 
        # or as a class:
        # 
        #   class NewClass < SuperKlass
        #   end
        # 
        # Configuration options:
        # <tt>superclass</tt> - The class to inherit from.  This only applies when using Class#create.  Default is Object.
        # <tt>parent</tt> - The class/module that contains this module.  Default is Object.
        # 
        # Examples:
        # 
        #   Module.create('Foo')                                                      # => Foo
        #   Module.create('Bar', :parent => Foo)                                      # => Foo::Bar
        #   Class.create('Waddle')                                                    # => Waddle
        #   Class.create('Widdle', :parent => Waddle)                                 # => Waddle::Widdle
        #   Class.create('Woddle', :superclass => Waddle::Widdle, :parent => Waddle)  # => Waddle::Woddle
        #   Waddle::Woddle.superclass                                                 # => Waddle::Widdle
        def create(name, options = {}, &block)
          options.assert_valid_keys(
            :superclass,
            :parent
          )
          raise ArgumentError, 'Modules cannot have superclasses' if options[:superclass] && self.to_s == 'Module'
          
          options.reverse_merge!(
            :superclass => ::Object,
            :parent => ::Object
          )
          parent = options[:parent]
          superclass = options[:superclass]
          
          if superclass != ::Object
            superclass = " < ::#{superclass}"
          else
            superclass = ''
          end
          
          parent.class_eval <<-end_eval
            #{self.to_s.downcase} #{name}#{superclass}
            end
          end_eval
          
          mod = parent.const_get(name)
          mod.class_eval(&block) if block_given?
          mod
        end
      end
    end
  end
end

::Module.class_eval do
  extend PluginAWeek::CoreExtensions::Module::ModuleCreationHelper
end
