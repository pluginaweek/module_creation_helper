require File.dirname(__FILE__) + '/test_helper'

module Ford
end

class Vehicle
  cattr_accessor :test_name
  cattr_accessor :test_inspect
  cattr_accessor :test_to_s
  
  def self.inherited(base)
    self.test_name = base.name
    self.test_inspect = base.inspect
    self.test_to_s = base.to_s
  end
end

class ModuleCreationHelperTest < Test::Unit::TestCase
  def test_should_raise_exception_if_invalid_option_specified
    assert_raise(ArgumentError) {Class.create(nil, :invalid => true)}
  end
end

class ModuleCreationHelperForClassTest < Test::Unit::TestCase
  def setup
    @car = Class.create('Car')
  end
  
  def test_should_have_object_as_superclass
    assert_equal Object, @car.superclass
  end
  
  def test_should_have_object_as_parent
    assert_equal Object, @car.parent
    assert Object.const_defined?('Car')
  end
  
  def teardown
    Object.send(:remove_const, 'Car')
  end
end

class ModuleCreationHelperForClassWithSuperclassTest < Test::Unit::TestCase
  def setup
    @car = Class.create('Car', :superclass => Vehicle)
  end
  
  def test_should_inherit_from_superclass
    assert_equal Vehicle, @car.superclass
  end
  
  def test_should_have_object_as_parent
    assert_equal Object, @car.parent
    assert Object.const_defined?('Car')
  end
  
  def test_should_evaluate_name_as_name
    assert_equal 'Car', Vehicle.test_name
  end
  
  def test_should_evaluate_inspect_as_name
    assert_equal 'Car', Vehicle.test_inspect
  end
  
  def test_should_evaluate_to_s_as_name
    assert_equal 'Car', Vehicle.test_to_s
  end
  
  def teardown
    Object.send(:remove_const, 'Car')
  end
end

class ModuleCreationHelperForClassWithParentTest < Test::Unit::TestCase
  def setup
    @car = Class.create('Car', :parent => Ford)
  end
  
  def test_should_have_object_as_superclass
    assert_equal Object, @car.superclass
  end
  
  def test_should_be_nested_within_parent
    assert_equal Ford, @car.parent
    assert Ford.const_defined?('Car')
  end
  
  def teardown
    Ford.send(:remove_const, 'Car')
  end
end

class ModuleCreationHelperForClassWithSuperclassAndParentTest < Test::Unit::TestCase
  def setup
    Vehicle.test_name = nil
    Vehicle.test_inspect = nil
    Vehicle.test_to_s = nil
    
    @car = Class.create('Car', :superclass => Vehicle, :parent => Ford)
  end
  
  def test_should_inherit_from_superclass
    assert_equal Vehicle, @car.superclass
  end
  
  def test_should_be_nested_within_parent
    assert_equal Ford, @car.parent
    assert Ford.const_defined?('Car')
  end
  
  def test_should_evaluate_name_as_name
    assert_equal 'Ford::Car', Vehicle.test_name
  end
  
  def test_should_evaluate_inspect_as_name
    assert_equal 'Ford::Car', Vehicle.test_inspect
  end
  
  def test_should_evaluate_to_s_as_name
    assert_equal 'Ford::Car', Vehicle.test_to_s
  end
  
  def teardown
    Ford.send(:remove_const, 'Car')
  end
end

class ModuleCreationHelperForClassWithDynamicSuperclassTest < Test::Unit::TestCase
  def setup
    @car = Class.create('Car')
    @convertible = Class.create('Convertible', :superclass => @car)
  end
  
  def test_should_inherit_from_superclass
    assert_equal @car, @convertible.superclass
  end
  
  def teardown
    Object.send(:remove_const, 'Convertible')
    Object.send(:remove_const, 'Car')
  end
end

class ModuleCreationHelperForClassWithCustomMethods < Test::Unit::TestCase
  def setup
    @car = Class.create('Car', :superclass => Vehicle) do
      def self.color
        'red'
      end
    end
  end
  
  def test_should_evaluate_methods
    assert_equal 'red', Car.color
  end
  
  def teardown
    Object.send(:remove_const, 'Car')
  end
end

class ModuleCreationHelperForModuleTest < Test::Unit::TestCase
  def setup
    @autopilot = Module.create('Autopilot')
  end
  
  def test_should_have_object_as_parent
    assert_equal Object, @autopilot.parent
    assert Object.const_defined?('Autopilot')
  end
  
  def teardown
    Object.send(:remove_const, 'Autopilot')
  end
end

class ModuleCreationHelperForModuleWithSuperclassTest < Test::Unit::TestCase
  def test_should_raise_an_exception
    assert_raise(ArgumentError) {Module.create(nil, :superclass => Object)}
  end
end

class ModuleCreationHelperForModuleWithParentTest < Test::Unit::TestCase
  def setup
    @autopilot = Module.create('Autopilot', :parent => Ford)
  end
  
  def test_should_be_nested_within_parent
    assert_equal Ford, @autopilot.parent
    assert Ford.const_defined?('Autopilot')
  end
  
  def teardown
    Ford.send(:remove_const, 'Autopilot')
  end
end
