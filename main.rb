require_relative 'config/application'

ca = CA.new

alice = Person.new('Alice')
bob = Person.new('Bob')

alice.key_pair = ca.generate_keys
bob.key_pair = ca.generate_keys

print alice.key_pair.public_key
print alice.key_pair.private_key