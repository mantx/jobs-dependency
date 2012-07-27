# encoding: utf-8
require './test_helper'

class JobsDependencyTest < Test::Unit::TestCase
  def test_jobs_dependency_new
    jd = JobsDependency.new
    assert_kind_of JobsDependency, jd, "should new a instance of JobsDependency"
  end

  def test_jobs_dependency_empty_str
    jd = JobsDependency.new
    assert_equal "", jd.output, "should be an empty"
  end

  def test_jobs_dependency_case1
    jd = JobsDependency.new "a=>"
    assert_equal "a", jd.output, "should be 'a'"
  end

  def test_jobs_dependency_case2
    jd = JobsDependency.new "a=>, b=>, c=>"
    ['a','b','c'].each {|letter| assert jd.output.include?(letter), "should be a sequence containing all three jobs abc in no significant order"}
  end

  def test_jobs_dependency_case3
    jd = JobsDependency.new "a=>, b=>c, c=>"
    result = jd.output
    assert result.index('c')>result.index('b'), "should be a sequence that positions c before b, containing all three jobs abc"
  end

  def test_jobs_dependency_case4_withError
    jd = JobsDependency.new "a=>, b=>, c=>c"
    assert_raise RuntimeError, "jobs can’t depend on themselves" do
      jd.check
    end
  end

  def test_jobs_dependency_case5_withError
    jd = JobsDependency.new "a=>, b=>c, c=>f, d=>a, e=>, f=>b"
    assert_raise RuntimeError, "jobs can’t have circular dependencies" do
      jd.check
    end
  end
end
