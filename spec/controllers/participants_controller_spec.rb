require 'spec_helper'

describe ParticipantsController do
  let(:user) { mock_model(UserAccount) }
  let(:crew) { mock_model(Crew) }
  let(:last_name) { "Smith" }
  let(:first_name) { "Gwen" }
  let(:participant) { mock_model(Participant, user_account: user, crew: crew,
    last_name: last_name, first_name: first_name, display_name: "#{first_name} #{last_name}").as_null_object }
  let(:success_message) { "#{participant.display_name} has been " }
  let(:create_message) { success_message + "successfully registered as Blue Trolley event participant" }
  let(:update_message) { "#{participant.display_name} profile has been successfully updated" }
  let(:delete_message) { success_message + "deleted from Blue Trolley participants list" }
  before do
    Participant.stub(:new).and_return(participant)
    Participant.stub(:find).and_return(participant)
  end


  describe "GET new" do
    it "creates a new participant" do
      Participant.should_receive(:new).with(:user_account_id => "#{participant.user_account.id}",
        :crew_id => "#{participant.crew.id}").and_return(participant)
      get_new
    end

    it "assigns participant" do
      get_new
      should_assign_participant
    end

    it "renders new template" do
      get_new
      response.should render_template(:new)
    end
  end


  describe "POST create" do
    it "creates a new participant" do
      Participant.should_receive(:new).with("last_name" => last_name,
        "first_name" => first_name).and_return(participant)
      post_create
    end

    it "saves the participant" do
      participant.should_receive(:save).and_return(true)
      post_create
    end

    context "when participant saves successfully" do
      before { post_create }
      specify { should_flash_success create_message }
      it { should redirect_to(user_account_path user) }
    end

    context "when participant fails to save" do
      before do
        participant.stub(:save).and_return(false)
        post_create
      end

      specify { should_assign_participant }
      it { should render_template(:new) }
    end
  end


  describe "GET edit" do
    it "finds participant by id" do
      should_be_found_by_id
      get_edit
    end

    it "assigns participant" do
      get_edit
      should_assign_participant
    end

    it "renders edit template" do
      get_edit
      response.should render_template(:edit)
    end
  end


  describe "PUT update" do
    it "finds participant by id" do
      should_be_found_by_id
      put_update
    end

    it "performs update operation" do
      participant.should_receive(:update).with("last_name" => "#{last_name}",
        "first_name" => "#{first_name}").and_return(true)
      put_update
    end

    context "when participant updates successfully" do
      before { put_update }
      specify { should_flash_success update_message }
      it { should redirect_to(user_account_path user) }
    end

    context "when participant fails to update" do
      before do
        participant.stub(:update).and_return(false)
        put_update
      end

      specify { should_assign_participant }
      it { should render_template(:edit) }
    end
  end


  describe "DELETE destroy" do
    it "finds participant by id" do
      should_be_found_by_id
      delete_destroy
    end

    it "assigns participant" do
      delete_destroy
      should_assign_participant
    end

    it "destroys the participant" do
      participant.should_receive(:destroy)
      delete_destroy
    end

    it "displays a flash success delete message" do
      delete_destroy
      should_flash_success delete_message
    end

    it "redirects to user account profile" do
      delete_destroy
      response.should redirect_to(user_account_path user)
    end
  end


private
  def get_new
    get :new, user_account_id: user.id, crew_id: crew.id
  end

  def post_create
    post :create, participant: { last_name: last_name, first_name: first_name }
  end

  def get_edit
    get :edit, id: participant.id
  end

  def put_update
    put :update, id: participant.id, participant: { last_name: last_name, first_name: first_name }
  end

  def delete_destroy
    delete :destroy, id: participant.id
  end

  def should_be_found_by_id
    Participant.should_receive(:find).with("#{participant.id}").and_return(participant)
  end

  def should_assign_participant
    assigns[:participant].should eq(participant)
  end

  def should_flash_success(message)
    flash[:success].should == message
  end
end
