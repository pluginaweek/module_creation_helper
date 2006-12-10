require File.dirname(__FILE__) + '/test_helper'

module TestParent
end

class TestSuperclass
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
  def setup
    TestSuperclass.test_name = nil
    TestSuperclass.test_inspect = nil
    TestSuperclass.test_to_s = nil
  end
  
  def test_no_options_for_class
    klass = Class.create('Foo')
    assert_equal Object, klass.superclass
    assert_equal Object, klass.parent
    assert Object.const_defined?('Foo')
  end
  
  def test_no_options_for_module
    mod = Module.create('FooMod')
    assert_equal Object, mod.parent
    assert Object.const_defined?('FooMod')
  end
  
  def test_invalid_option
    assert_raise(ArgumentError) {Class.create(nil, :invalid => true)}
  end
  
  def test_superclass_for_module
    assert_raise(ArgumentError) {Module.create(nil, :superclass => Object)}
  end
  
  def test_superclass
    klass = Class.create('Bar', :superclass => TestSuperclass)
    assert_equal TestSuperclass, klass.superclass
    assert_equal Object, klass.parent
    assert Object.const_defined?('Bar')
  end
  
  def test_parent_for_class
    klass = Class.create('Baz', :parent => TestParent)
    assert_equal Object, klass.superclass
    assert_equal TestParent, klass.parent
    assert TestParent.const_defined?('Baz')
  end
  
  def test_parent_for_module
    mod = Module.create('BazMod', :parent => TestParent)
    assert_equal TestParent, mod.parent
    assert TestParent.const_defined?('BazMod')
  end
  
  def test_superclass_and_parent
    klass = Class.create('Biz', :superclass => TestSuperclass, :parent => TestParent)
    assert_equal TestSuperclass, klass.superclass
    assert_equal TestParent, klass.parent
    assert TestParent.const_defined?('Biz')
  end
  
  def test_name_before_evaluated
    klass = Class.create('Waddle', :superclass => TestSuperclass)
    assert_equal 'Waddle', TestSuperclass.test_name
  end
  
  def test_inspect_before_evaluated
    klass = Class.create('Widdle', :superclass => TestSuperclass)
    assert_equal 'Widdle', TestSuperclass.test_inspect
  end
  
  def test_to_s_before_evaluated
    klass = Class.create('Wuddle', :superclass => TestSuperclass)
    assert_equal 'Wuddle', TestSuperclass.test_to_s
  end
  
  def test_name_before_evaluated_with_parent
    klass = Class.create('Waddle', :superclass => TestSuperclass, :parent => TestParent)
    assert_equal 'TestParent::Waddle', TestSuperclass.test_name
  end
  
  def test_inspect_before_evaluated_with_parent
    klass = Class.create('Widdle', :superclass => TestSuperclass, :parent => TestParent)
    assert_equal 'TestParent::Widdle', TestSuperclass.test_inspect
  end
  
  def test_to_s_before_evaluated_with_parent
    klass = klass = Class.create('Wuddle', :superclass => TestSuperclass, :parent => TestParent)
    assert_equal 'TestParent::Wuddle', TestSuperclass.test_to_s
  end
  
  def test_subclass_of_dynamic_class
    klass = Class.create('Foobar')
    subclass = Class.create('Foobaz', :superclass => klass)
    
    assert_equal klass, subclass.superclass
    assert_equal 'Foobaz', subclass.name
    assert_equal 'Foobaz', subclass.inspect
    assert_equal 'Foobaz', subclass.to_s
  end
  
  def test_with_block
    klass = Class.create('ClassWithBlock', :superclass => TestSuperclass) do
      def self.say_hello
        'hello'
      end
    end
    assert_equal 'hello', ClassWithBlock.say_hello
  end
  
  def test_nested_class_with_superclass_with_same_name
    klass = Class.create('Employee')
    nested_class = Class.create('Employee', :superclass => klass, :parent => TestParent)
    assert_equal klass, nested_class.superclass
  end
  
  private
  def klass_with_id(klass)
    "#<Class:0x#{(klass.object_id * 2).to_s(16)}>"
  end
end
