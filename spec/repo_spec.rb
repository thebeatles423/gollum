require 'spec_helper'

describe Repo do
    
  before(:all) do
    @create_new = true
    @temp_repo_path = create_temp_repo(TEST_REPO_PATH)
    @temp_bare_repo_path = create_temp_repo(TEST_BARE_REPO_PATH)
    @repo = Repo.new(@temp_repo_path)
    @bare_repo = Repo.new(@temp_bare_repo_path, {:bare => true}, false)
  end
    
  it "should default to a non-bare repository path" do
    @repo.path.should eql @temp_repo_path + '/.git'
  end
  
  it "should have a bare repository path if specified" do
    File.basename(@bare_repo.path).should_not eql ".git"
  end
  
  it "should create a new repository if specified" do
    filename = 'git_create_test' + Time.now.to_i.to_s + rand(300).to_s.rjust(3, '0')
    tmp_path = File.join("/tmp/", filename)
    new_repo = Repo.new(tmp_path, {:bare => false}, @create_new)
    (tmp_path + '/.git').should exist
  end

  it "should create a new bare repository if specified" do
    filename = 'git_create_bare_test' + Time.now.to_i.to_s + rand(300).to_s.rjust(3, '0')
    tmp_path = File.join("/tmp/", filename)
    new_bare_repo = Repo.new(tmp_path, {:bare => true}, @create_new)
    tmp_path.should be_a_directory
  end
  
  it "should tell us whether it is bare" do
    @repo.should_not be_bare
    @bare_repo.should be_bare
  end
  
  it "should have a reference to a JGit Repository object" do
    @repo.repo.should be_a org.eclipse.jgit.lib.Repository 
  end
  
  it "should list the current branch" do
    @repo.branch.should == "master"
  end
  
  it "should list its branches" do
    result = @repo.branches
    result.should be_an Array
    pending("Repo#branches currently returns []. Needs implementation.")
    result.should include("master")
  end
  
  it "should return its description" do
    result = @repo.description
    pending("repo_description fixture does not yet exist")
    result.should eql fixture("repo_description")
  end
  
  it "should list its commits" do
    @repo.commits.should be_an Array
    @repo.commits.length.should == 3
  end
  
  it "should add files to itself" 
  
  it "should return a Blob by name" do
    blob = @bare_repo.blob('Manifest.txt')
    # tree_id.should be_an ObjectId
    # blob.should be_a RevBlob
    # blob.name.should == "Manifest.txt"
    pending("Not finished implementing the example.")
  end
  
  it "should return a Tree by name" 
  
end