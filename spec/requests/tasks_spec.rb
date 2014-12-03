require 'rails_helper'

RSpec.describe "Tasks", :type => :request do
  before do
    @task = Task.create(task: "go to bed", due: "2015-01-01")
  end
  describe "GET /tasks" do
    it "display some tasks" do
      visit tasks_path
      expect(page).to have_content "go to bed"
    end

    it "creates a new task" do
      visit tasks_path
      click_link "Create New Task"
      fill_in "Task", :with => "go to work"
      fill_in "Due", :with => "2015-01-01"
      click_button "Create Task"

      expect(current_path) ==  tasks_path
      expect(page).to have_content "go to work"
      expect(page).to have_content "2015-01-01"

      #save_and_open_page
    end
  end

  describe "PUT /tasks" do
    it "edits a task" do
      visit tasks_path
      click_link "Edit"

      expect(current_path) == edit_task_path(@task)

      expect(find_field("Task")) == "go to bed"
      expect(find_field("Due")) == "2015-01-01"      

      fill_in "Task", :with => "sleep"
      fill_in "Due", :with => "2015-01-02"
      click_button "Update Task"

      expect(current_path) == tasks_path

      expect(page).to have_content "sleep"
      expect(page).to have_content "2015-01-02"
    end

    it "should not update an empty task" do
      visit tasks_path
      click_link "Edit"

      fill_in "Task", :with => ""
      click_button "Update Task"

      expect(current_path) == edit_task_path(@task)      
      expect(page).to have_content "error prohibited this task from being saved"
    end
  end

  describe "DELETE /tasks" do
    it "should delete a task" do
      visit tasks_path
      find("#task_#{@task.id}").click_link "Delete"
      expect(page).to have_content "Task has been deleted."
      expect(page).to have_no_content "go to bed"
    end
  end
end
