require 'spec_helper'

describe ParticipantsController do
  let(:user) { mock_user_account }
  let(:crew) { mock_crew }
  let(:last_name) { "Smith" }
  let(:first_name) { "Gwen" }
  let(:participant) { mock_participant(user_account: user, crew: crew, email: 'someaddress@gmail.com',
    last_name: last_name, first_name: first_name, display_name: "#{first_name} #{last_name}") }

  let(:success_message) { "#{participant.display_name} has been " }
  let(:create_message) { success_message + "successfully registered as Blue Trolley event participant." }
  let(:update_message) { "#{participant.display_name} profile has been successfully updated." }
  let(:delete_message) { success_message + "deleted from Blue Trolley participants list." }

  before do
    Participant.stub(:new).and_return(participant)
    Participant.stub(:find).and_return(participant)
  end


  describe "GET new" do
    it "creates a new participant" do
      Participant.should_receive(:new).with(:user_account_id =>
        "#{participant.user_account.id}").and_return(participant)
      get_new
    end

    it { should_assign(participant: participant) { get_new } }

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
      let(:crew_lead) { mock_user_account(email: 'boss@bossfirm.com', crew_lead: true, crew: participant.crew) }
      before do
        participant.stub(:save).and_return(true)
        crew_lead.crew.stub(:emails).and_return([crew_lead.email])
      end

      it "sends email to newly created participant" do
        ->{ post_create }.should send_email(ParticipantsMailer, to: participant.email,
          subject: "#{sender}: #{participant_created_subject}")
      end
      it "sends email to the crew lead" do
        ->{ post_create }.should send_email(ParticipantsMailer, to: crew_lead.email,
          subject: "#{sender}: #{approval_request_subject}")
      end

      specify { expect_to_flash_success(create_message) { post_create } }

      it "redirects to user profile page" do
        post_create
        should redirect_to(user_account_path user)
      end
    end

    context "when participant fails to save" do
      before do
        participant.stub(:save).and_return(false)
        post_create
      end

      it { should_assign participant: participant }
      it { should render_template(:new) }
    end
  end


  describe "GET edit" do
    it "finds participant by id" do
      should_be_found_by_id
      get_edit
    end

    it { should_assign(participant: participant) { get_edit } }

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
      before do
        participant.stub(:update).and_return(true)
        put_update
      end

      specify { expect_to_flash_success update_message }
      it { should redirect_to(user_account_path user) }
    end

    context "when participant fails to update" do
      before do
        participant.stub(:update).and_return(false)
        put_update
      end

      it { should_assign participant: participant }
      it { should render_template(:edit) }
    end
  end


  describe "DELETE destroy" do
    it "finds participant by id" do
      should_be_found_by_id
      delete_destroy
    end

    it { should_assign(participant: participant) { delete_destroy } }
    specify { expect_to_flash_success(delete_message) { delete_destroy } }

    it "destroys the participant" do
      participant.should_receive(:destroy)
      delete_destroy
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
end
