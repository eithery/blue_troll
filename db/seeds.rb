# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

events = Event.create([
	{ name: 'Blue Trolley 2013 Fall', from: '2013-06-27', to: '2013-06-27',
		location: 'Delaware Water Gap / Pocono Mountain KOA  233 Hollow Road, East Stroudsburg, PA 18302' }
])


crews = Crew.create([
	{ name: 'Bells', native_name: 'Звон Вечерний' },
	{ name: 'Besprizorniki', native_name: 'Беспризорники' },
	{ name: 'Carolinian Robins', native_name: 'Каролинские красношейки' },
	{ name: 'Castaway', active: false },
	{ name: 'Chesapeake', active: false },
	{ name: 'Chetakticha', active: false },
	{ name: 'Drummers', native_name: 'Барабанщики' },
	{ name: 'Dubki', native_name: 'Дубки' },
	{ name: 'Elki-Palki', native_name: 'Ёлки-Палки' },
	{ name: 'El-Tor', native_name: 'Эль-Тор' },
	{ name: 'Green Carriage', native_name: 'Зелёная Карета' },
	{ name: 'GTO', native_name: 'ГТО' },
	{ name: 'Guests', native_name: 'Гости Слета' },
	{ name: 'Happy Crew', native_name: 'Веселые Ребята' },
	{ name: 'Inner Voice', native_name: 'Внутренний Голос' },
	{ name: 'JVP', active: false },
	{ name: 'Kazaki-Razboiniki', native_name: 'Казаки-Разбойники' },
	{ name: 'Left Coast', native_name: 'Левый Берег' },
	{ name: 'Mandamus', native_name: 'Мандамус' },
	{ name: 'My People', native_name: 'Свои Люди' },
	{ name: 'Na Bis', native_name: 'На Бис', active: false },
	{ name: 'Okhotnyj Ryad', native_name: 'Охотный Ряд' },
	{ name: 'Palata #6', native_name: 'Палата №6' },
	{ name: 'Pegassus', native_name: 'Пегас' },
	{ name: 'POA', active: false },
	{ name: 'Pshik & Co', native_name: 'Пшик и Ко.' },
	{ name: 'Sentjabrjata', native_name: 'Сентябрята'},
	{ name: 'Station Razliv', native_name: 'Станция Разлив' },
	{ name: 'Stranniki', native_name: 'Странники' },
	{ name: 'Tom Sawyer', native_name: 'Том Сойер', active: false },
	{ name: 'Trojan Donkeys', native_name: 'Троянские Ослики' },
	{ name: 'Trjam', native_name: 'Трям' },
	{ name: 'Volchij Hvost', native_name: 'Шайка-Лейка Волчий Хвост' },
	{ name: 'White Crow', native_name: 'Белая Ворона' },
	{ name: 'Zorro', native_name: 'Зорро', active: false }
])
