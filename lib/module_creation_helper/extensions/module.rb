module PluginAWeek #:nodoc:
  module ModuleCreationHelper
    module Extensions #:nodoc:
      # Adds helper methods for easily generating new modules/classes
      module Module
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
        # * +superclass+ - The class to inherit from.  This only applies when using Class#create.  Default is Object.
        # * +parent+ - The class/module that contains this module.  Default is Object.
        # 
        # == Examples
        # 
        #   Module.create('Foo')                                                      # => Foo
        #   Module.create('Bar', :parent => Foo)                                      # => Foo::Bar
        #   Class.create('Waddle')                                                    # => Waddle
        #   Class.create('Widdle', :parent => Waddle)                                 # => Waddle::Widdle
        #   Class.create('Woddle', :superclass => Waddle::Widdle, :parent => Waddle)  # => Waddle::Woddle
        #   Waddle::Woddle.superclass                                                 # => Waddle::Widdle
        # 
        # == Setting the parent
        # 
        # Rather than setting the parent directly using the +parent+ configuration
        # option, you can specify it in the actual name of the class like so:
        # 
        #   Module.create('Foo::Bar')   # => Foo::Bar
        # 
        # This has the same effect as the following:
        # 
        #   Module.create('Bar', :parent => Foo)
        def create(name, options = {}, &block)
          # Validate the provided options
          invalid_options = options.keys - [:superclass, :parent]
          raise ArgumentError, "Unknown key(s): #{invalid_options.join(", ")}" unless invalid_options.empty?
          
          # Validate usage of :superclass option
          raise ArgumentError, 'Modules cannot have superclasses' if options[:superclass] && self.to_s == 'Module'
          
          options = {:superclass => Object, :parent => Object}.merge(options)
          parent = options[:parent]
          superclass = options[:superclass]
          
          if superclass != Object
            superclass = " < ::#{superclass}"
          else
            superclass = ''
          end
          
          mod = parent.class_eval <<-end_eval
            #{self.to_s.downcase} #{name}#{superclass}
              self
            end
          end_eval
          
          mod.class_eval(&block) if block_given?
          mod
        end
      end
    end
  end
end

Module.class_eval do
  extend PluginAWeek::ModuleCreationHelper::Extensions::Module
end
