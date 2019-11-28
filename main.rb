require_relative 'config/application'

ca = CA.new
rsa = RSA.new

alice = Person.new('Alice')
bob = Person.new('Bob')

alice.public_key, alice.private_key = ca.generate_keys
bob.public_key, bob.private_key = ca.generate_keys

original_message = "rafael alves fernandes"
ciphed_message = rsa.encrypt(original_message, alice.public_key)
deciphed_message = rsa.decrypt(ciphed_message, alice.private_key)
