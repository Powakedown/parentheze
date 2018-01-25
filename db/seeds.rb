Wish.destroy_all

puts 'All tables are destroyed'

Wish.create!(name: 'J’ai besoin de faire garder mes enfants')
Wish.create!(name: 'Je suis prêt à accueillir les enfants de mes voisins')
Wish.create!(name: 'J’accepte les invitations pour faire connaissance')
Wish.create!(name: 'J’accepte les échanges et les dons de matériel entre voisins')

puts '4 wishes created'
