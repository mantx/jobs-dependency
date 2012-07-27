#!/usr/bin/env ruby

require './lib/jobs_dependency'
include ShawnLib


def analyseJobDependency jobs
  jd = JobsDependency.new jobs
  puts "Given the following job structure:"
  puts jobs
  puts "The result is:"
  jd.print
  puts ""
end


#sample 1
analyseJobDependency ""

#sample 2
analyseJobDependency "a=>"

#sample 3
analyseJobDependency "a=>, b=>, c=>"

#sample 4
analyseJobDependency "a=>, b=>c, c=>"

#sample 5
analyseJobDependency "a=>, b=>c, c=>f, d=>a, e=>b, f=>"

#sample 6
analyseJobDependency "a=>, b=>, c=>c"

#sample 7
analyseJobDependency "a=>, b=>c, c=>f, d=>a, e=>, f=>b"
