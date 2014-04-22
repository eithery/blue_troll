module DomainModelMocks
  def mock_user_account(stubs={})
    user = mock_model(UserAccount, login: 'johnsmith', name: 'johnsmith', email: 'johnsmith@gmail.com').as_null_object
    stubs.each { |key, val| user.stub(key).and_return(val) }
    user
  end


  def mock_new_user_account
    mock_model(UserAccount).as_new_record
  end


  def mock_participant(stubs={})
    participant = mock_model(Participant, user_account: mock_user_account).as_null_object
    stubs.each { |key, val| participant.stub(key).and_return(val) }
    participant
  end


  def stub_participant(stubs={})
    participant = stub_model(Participant, user_account: mock_user_account, crew: mock_crew, last_name: 'Smith',
      first_name: 'Gwen', age_category: AgeCategory::BABY, age: 3, email: 'gwen@gmail1.com',
      cell_phone: '347-583-0140', address_line_1: '31 Gadsen Pl Staten Island NY 10314')

    stubs.each { |key, val| participant.stub(key).and_return(val) }
    participant
  end


  def stub_new_participant(stubs={})
    participant = stub_model(Participant, user_account: mock_user_account).as_new_record
    stubs.each { |key, val| participant.stub(key).and_return(val) }
    participant
  end


  def mock_crew
    mock_model(Crew, name: 'Guests', native_name: 'Гости Слета').as_null_object
  end


  def mock_crews
    [
      mock_model(Crew, name: 'Enemy spies', native_name: 'Вражеские шпионы').as_null_object,
      mock_model(Crew, name: 'Mr Fix Friends', native_name: 'Друганы Мистера Фикса').as_null_object,
      mock_crew
    ]
  end
end
