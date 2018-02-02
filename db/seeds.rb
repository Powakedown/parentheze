Wish.destroy_all

puts 'All tables are destroyed'

Wish.create!(number: 0, name: 'J’ai besoin de faire garder mes enfants')
Wish.create!(number: 1, name: 'Je suis prêt à accueillir les enfants de mes voisins')
Wish.create!(number: 2, name: 'J’accepte les invitations pour faire connaissance')
Wish.create!(number: 3, name: 'J’accepte les échanges et les dons de matériel entre voisins')

puts '4 wishes created'
