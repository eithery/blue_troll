class PopulateCrewLeads < ActiveRecord::Migration
  def up
    @crews = [
      { name: 'Bells', native_name: 'Звон Вечерний' },
      { name: 'Carolinian Robbins', native_name: 'Каролинские красношейки' },
      { name: 'Drummers', native_name: 'Барабанщики' },
      { name: 'Dubki', native_name: 'Дубки' },
      { name: 'Elki-Palki', native_name: 'Ёлки-Палки' },
      { name: 'El-Tor', native_name: 'Эль-Тор' },
      { name: 'Green Carriage', native_name: 'Зеленая Карета' },
      { name: 'GTO', native_name: 'ГТО' },
      { name: 'Guests', native_name: 'Гости Слета' },
      { name: 'Happy Crew', native_name: 'Веселые Ребята' },
      { name: 'Homeless', native_name: 'Беспризорники' },
      { name: 'Inner Voice', native_name: 'Внутренний Голос' },
      { name: 'Kazaki-Razboiniki', native_name: 'Казаки-Разбойники' },
      { name: 'Left Coast', native_name: 'Левый Берег' },
      { name: 'Mandamus', native_name: 'Мандамус' },
      { name: 'My People', native_name: 'Свои Люди' },
      { name: 'North People', native_name: 'Люди Севера', active: false },
      { name: 'Okhotnyj Ryad', native_name: 'Охотный ряд' },
      { name: 'Palata #6', native_name: 'Палата №6' },
      { name: 'Pegassus', native_name: 'Пегас' },
      { name: 'Pshik & Co', native_name: 'Пшик и компания' },
      { name: 'Sentyabryata', native_name: 'Сентябрята' },
      { name: 'Station Razliv', native_name: 'Станция Разлив' },
      { name: 'Stranniki', native_name: 'Странники' },
      { name: 'Tom Sawyer', native_name: 'Том Сойер' },
      { name: 'Trjam', native_name: 'ТRЯМ' },
      { name: 'Trojan Donkeys', native_name: 'Троянские Ослики' },
      { name: 'White Crow', native_name: 'Белая Ворона' },
      { name: "Wolf's Tail", native_name: 'Шайка-Лейка Волчий Хвост' },
      { name: 'Voices of Virginia', native_name: 'Голоса Вирджинии' }
    ]

    Crew.create!(@crews)


    @user_accounts = [
      { login: 'alexshayk', email: 'alexshayk@yahoo.com', password: generate, crew: crew(9), admin: true },
      { login: 'ashaykevich', email: 'alexshayk@gmail.com', password: generate, crew: crew(11) },
      { login: 'ypogorelsky', email: 'ypogorelsky@hotmail.com', password: generate, crew: crew(1) },
      { login: 'izaverukha', email: 'ilyazaver@gmail.com', password: generate, crew: crew(2) },
      { login: 'rhamon', email: 'romanhamon3@yahoo.com', password: generate, crew: crew(3) },
      { login: 'bserebrenik', email: 'bserebrenik@gmail.com', password: generate, crew: crew(3) },
      { login: 'ituchina', email: 'iratuchin@netscape.net', password: generate, crew: crew(4) },
      { login: 'apolyakov', email: 'alekspolyakov@yahoo.com', password: generate, crew: crew(5) },
      { login: 'abelyaev', email: 'alexander@belyayev.com', password: generate, crew: crew(6) },
      { login: 'idricker', email: 'ilya.dricker@gmail.com', password: generate, crew: crew(7) },
      { login: 'mbrandis', email: 'leto4you@yahoo.com', password: generate, crew: crew(8) },
      { login: 'igudgarts', email: 'morpeh92@yahoo.com', password: generate, crew: crew(10) },
      { login: 'makhmetov', email: 'marina.mashka@gmail.com', password: generate, crew: crew(12) },
      { login: 'agrinberg', email: 'annagrin@yahoo.com', password: generate, crew: crew(13) },
      { login: 'vkazakov', email: 'victorkazak@gmail.com', password: generate, crew: crew(13) },
      { login: 'dtalalaev', email: 'fatcatd@gmail.com', password: generate, crew: crew(14) },
      { login: 'vkosulin', email: 'kosulin@yahoo.com', password: generate, crew: crew(14) },
      { login: 'gpalitsky', email: 'superblin@gmail.com', password: generate, crew: crew(15) },
      { login: 'veidelstein', email: 'vishinka@yahoo.com', password: generate, crew: crew(16) },
      { login: 'ylev', email: 'yuri.j.lev@gmail.com', password: generate, crew: crew(18) },
      { login: 'ryeliseyev', email: 'ryeliseyev@gmail.com', password: generate, crew: crew(19), financier: true },
      { login: 'iaks', email: 'irina.akc@gmail.com', password: generate, crew: crew(20)},
      { login: 'jpliner', email: 'jplinerinteriors@gmail.com', password: generate, crew: crew(21) },
      { login: 'vkhazak', email: 'vladimirkhazak@yahoo.com', password: generate, crew: crew(22) },
      { login: 'azaks', email: 'demzak@yahoo.com', password: generate, crew: crew(23) },
      { login: 'omikaloff', email: 'omikaloff@yahoo.com', password: generate, crew: crew(24) },
      { login: 'ptyutyunik', email: 'petun7@gmail.com', password: generate, crew: crew(24) },
      { login: 'astolov', email: 'andrei_stolov@yahoo.com', password: generate, crew: crew(25) },
      { login: 'kkarpova', email: 'katekarpova@yahoo.com', password: generate, crew: crew(26) },
      { login: 'lrapoport', email: 'lvrapoport@gmail.com', password: generate, crew: crew(27) },
      { login: 'imashkovich', email: 'inna.mashkovich@power.alstom.com', password: generate, crew: crew(28) },
      { login: 'igrapp', email: 'igrapp@gmail.com', password: generate, crew: crew(29) },
      { login: 'tmusatov', email: 'btatyana@gwmail.gwu.edu', password: generate, crew: crew(30) }
    ]

    @user_accounts.each do |lead|
      lead[:email_confirmation] = lead[:email]
      lead[:password_confirmation] = lead[:password]
      lead[:crew_lead] = true
      lead[:active] = true
      lead[:activated_at] = Time.now
    end

    UserAccount.create!(@user_accounts)


    crew_leads = [
      { last_name: 'Shaykevich', first_name: 'Alex' },
      { last_name: 'Shaykevich', first_name: 'Alex' },
      { last_name: 'Pogorelsky', first_name: 'Yanina' },
      { last_name: 'Zaverukha', first_name: 'Ilya' },
      { last_name: 'Hamon', first_name: 'Roman' },
      { last_name: 'Serebrenik', first_name: 'Boris' },
      { last_name: 'Tuchina', first_name: 'Irina' },
      { last_name: 'Polyakov', first_name: 'Alex' },
      { last_name: 'Belyaev', first_name: 'Alexandr' },
      { last_name: 'Dricker', first_name: 'Ilya' },
      { last_name: 'Brandis', first_name: 'Margarita' },
      { last_name: 'Gudgarts', first_name: 'Igor' },
      { last_name: 'Akhmetov', first_name: 'Marina' },
      { last_name: 'Grinberg', first_name: 'Anna' },
      { last_name: 'Kazakov', first_name: 'Viktor' },
      { last_name: 'Talalaev', first_name: 'Dmitriy' },
      { last_name: 'Kosulin', first_name: 'Vlad' },
      { last_name: 'Palitsky', first_name: 'Gennady' },
      { last_name: 'Eidelstein', first_name: 'Victoria' },
      { last_name: 'Lev', first_name: 'Yuri' },
      { last_name: 'Yeliseyev', first_name: 'Rita' },
      { last_name: 'Aks', first_name: 'Irina' },
      { last_name: 'Pliner', first_name: 'Julia' },
      { last_name: 'Khazak', first_name: 'Vladimir' },
      { last_name: 'Zaks', first_name: 'Alex' },
      { last_name: 'Mikaloff', first_name: 'Oleg' },
      { last_name: 'Tyutyunik', first_name: 'Peter' },
      { last_name: 'Stolov', first_name: 'Andrei' },
      { last_name: 'Karpova', first_name: 'Kate' },
      { last_name: 'Rapoport', first_name: 'Lev' },
      { last_name: 'Mashkovich', first_name: 'Inna' },
      { last_name: 'Grapp', first_name: 'Igor' },
      { last_name: 'Musatov', first_name: 'Tatyana' }
    ]

    crew_leads.each_with_index do |lead, index|
      lead[:user_account] = UserAccount.find_by_login @user_accounts[index][:login]
      lead[:approved_at] = Time.now
      lead[:approved_by] = 'admin'
      lead[:created_by] = 'admin'
      lead[:updated_by] = 'admin'
    end

    Participant.create!(crew_leads)
  end


  def down
    Participant.destroy_all
    UserAccount.destroy_all
    Crew.destroy_all
  end


private
  def generate
    SecureRandom.urlsafe_base64
  end


  def crew(index)
    name = @crews[index - 1][:name]
    Crew.find_by_name(name)
  end
end
