require_relative 'config/application'

ca = CA.new
rsa = RSA.new

alice = Person.new('Alice')
bob = Person.new('Bob')

alice.key_pair = ca.generate_keys
bob.key_pair = ca.generate_keys

# print alice.key_pair.public_key
# print alice.key_pair.private_key

original_message = "rafael alves fernandes"
ciphed_message = rsa.encrypt(original_message, alice.key_pair.public_key)
deciphed_message = rsa.decrypt(ciphed_message, alice.key_pair.private_key)
