# encoding: utf-8

module ShawnLib
  class JobsDependency
    attr_accessor :jobs

    def initialize(jobs='') 
      @jobs = parseJobs jobs
      @jobs_reversed = @jobs.invert
    end 

    def destroy 
    end

    def print
      begin
        check
        puts output
      rescue => ex
        puts "Error: #{ex.message}"
      end
    end

    # check jobs dependencies
    def check
      @jobs.each do |j1, j2|
        next if j1.nil?
        raise "jobs can’t depend on themselves" if j1 == j2
        passedJobs = []
        until j2.nil? do
          passedJobs << j2
          j2 = @jobs[j2]
          raise "jobs can’t have circular dependencies" if passedJobs.include? j2
        end
      end
    end

    # return a string, which reflect on job dependencies 
    def output
      return @result unless @result.nil?
      result = ''
      jobs = @jobs.clone
      jobs.each do |j1, j2|
        next if j1.nil? || j2 == :__deleted
        job = findRoot j1
        until job.nil? do
          result << job.to_s
          #empty this job in hash table to avoid printing it again later
          jobs[job], job = :__deleted, jobs[job]
        end
      end
      @result = result
    end
    
    # private methods
    private
    
    # parse a string to a hash
    def parseJobs(jobs)
      result = {}
      jobs_as_arr = jobs.split(/[,\n]/)
      jobs_as_arr.each do |job|
        job_as_arry = job.split("=>")
        result[job_as_arry[0].strip.to_sym] = job_as_arry.length==2 ? job_as_arry[1].strip.to_sym : nil unless job_as_arry.length<1
      end
      result
    end

    # return root of ancestor of a job
    def findRoot job
      return job unless @jobs_reversed.key? job
      return findRoot @jobs_reversed[job]
    end

  end
end
