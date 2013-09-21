# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

events = Event.create([
	{ name: 'Blue Trolley 2013 Fall', from: '2013-06-27', to: '2013-06-27',
		location: 'Delaware Water Gap / Pocono Mountain KOA  233 Hollow Road, East Stroudsburg, PA 18302' }
])


crews = Crew.create([
	{ name: 'Bells', native_name: 'Звон Вечерний', captain: 'Yanina Pogorelsky', email: 'ypogorelsky@hotmail.com' },
	{ name: 'Homeless', native_name: 'Беспризорники', captain: 'Alex Shaykevich', email: 'alexshayk@yahoo.com' },
	{ name: 'Drummers', native_name: 'Барабанщики', captain: 'Roman Hamon; Boris Serebrenik',
		email: 'romanhamon3@yahoo.com; bserebrenik@gmail.com' },
	{ name: 'Dubki', native_name: 'Дубки', captain: 'Irina Tuchina', email: 'iratuchin@netscape.net' },
	{ name: 'Elki-Palki', native_name: 'Ёлки-Палки', captain: 'Alex Polyakov', email: 'alekspolyakov@yahoo.com' },
	{ name: 'El-Tor', native_name: 'Эль-Тор', captain: 'Alexandr Belyaev', email: 'alexander@belyayev.com' },
	{ name: 'GTO', native_name: 'ГТО', captain: 'Margarita Brandis', email: 'leto4you@yahoo.com' },
	{ name: 'Guests', native_name: 'Гости Слета', captain: 'Alex Shaykevich', email: 'alexshayk@yahoo.com' },
	{ name: 'Happy Crew', native_name: 'Веселые Ребята', captain: 'Bella Zaytseva', email: 'bzaytseva@aol.com' },
	{ name: 'Inner Voice', native_name: 'Внутренний Голос', captain: 'Marina Akhmetov', email: 'marina.mashka@gmail.com' },
	{ name: 'Kazaki-Razboiniki', native_name: 'Казаки-Разбойники', captain: 'Anna Grinberg; Viktor Kazakov',
		email: 'annagrin@yahoo.com; victorkazak@gmail.com; banana2731@comcast.net' },
	{ name: 'Left Coast', native_name: 'Левый Берег', captain: 'Dmitriy Talalaev; Vlad Kosulin',
		email: 'fatcatd@gmail.com; kosulin@yahoo.com' },
	{ name: 'Mandamus', native_name: 'Мандамус', captain: 'Gennady Palitsky', email: 'superblin@gmail.com' },
	{ name: 'My People', native_name: 'Свои Люди', captain: 'Vika Eidelstein', email: 'vishinka@yahoo.com' },
	{ name: 'North People', native_name: 'Люди Севера', captain: 'Igor Bely', email: 'igor.bely@gmail.com' },
	{ name: 'Palata #6', native_name: 'Палата №6', captain: 'Rita Yeliseyev',
		email: 'ryeliseyev@gmail.com; igarvel@gmail.com' },
	{ name: 'Pegassus', native_name: 'Пегас', captain: 'Irina Aks', email: 'irina.akc@gmail.com' },
	{ name: 'Station Razliv', native_name: 'Станция Разлив', captain: 'Alex Zaks', email: 'demzak@yahoo.com' },
	{ name: 'Tom Sawyer', native_name: 'Том Сойер', captain: 'Andrei Stolov', email: 'andrei_stolov@yahoo.com' },
	{ name: 'Trojan Donkeys', native_name: 'Троянские Ослики', captain: 'Lev Rapoport', email: 'lvrapoport@gmail.com' },
	{ name: 'Trjam', native_name: 'ТRЯМ', captain: 'Kate Karpova', email: 'katekarpova@yahoo.com' },
	{ name: "Wolf's Tail", native_name: 'Шайка-Лейка Волчий Хвост', captain: 'Igor Grapp', email: 'igrapp@gmail.com' },
	{ name: 'White Crow', native_name: 'Белая Ворона', captain: 'Inna Mashkovich',
		email: 'inna.mashkovich@power.alstom.com' }
])
