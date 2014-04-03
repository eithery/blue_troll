class CreateCrews < ActiveRecord::Migration
  def up
    create_table :crews do |t|
      t.string :name, null: false
      t.string :native_name, null: false
      t.boolean :active, null: false, default: true
      t.string :location
      t.text :notes
      t.timestamps
    end

    add_index :crews, :name, unique: true
    add_index :crews, :native_name, unique: true


    Crew.create!([
      { name: 'Bells', native_name: 'Звон Вечерний' },
      { name: 'Homeless', native_name: 'Беспризорники' },
      { name: 'Drummers', native_name: 'Барабанщики' },
      { name: 'Dubki', native_name: 'Дубки' },
      { name: 'Elki-Palki', native_name: 'Ёлки-Палки' },
      { name: 'El-Tor', native_name: 'Эль-Тор' },
      { name: 'GTO', native_name: 'ГТО' },
      { name: 'Guests', native_name: 'Гости Слета' },
      { name: 'Happy Crew', native_name: 'Веселые Ребята' },
      { name: 'Inner Voice', native_name: 'Внутренний Голос' },
      { name: 'Kazaki-Razboiniki', native_name: 'Казаки-Разбойники' },
      { name: 'Left Coast', native_name: 'Левый Берег' },
      { name: 'Mandamus', native_name: 'Мандамус' },
      { name: 'My People', native_name: 'Свои Люди' },
      { name: 'North People', native_name: 'Люди Севера' },
      { name: 'Palata #6', native_name: 'Палата №6' },
      { name: 'Pegassus', native_name: 'Пегас' },
      { name: 'Station Razliv', native_name: 'Станция Разлив' },
      { name: 'Tom Sawyer', native_name: 'Том Сойер' },
      { name: 'Trojan Donkeys', native_name: 'Троянские Ослики' },
      { name: 'Trjam', native_name: 'ТRЯМ' },
      { name: "Wolf's Tail", native_name: 'Шайка-Лейка Волчий Хвост' },
      { name: 'White Crow', native_name: 'Белая Ворона' }
    ])
  end


  def down
    drop_table :crews
  end
end
