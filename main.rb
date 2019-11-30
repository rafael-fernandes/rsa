require_relative 'config/application'

logger = TTY::Logger.new { |config| config.level = $TTY_LEVEL }

ca = CA.new
rsa = RSA.new

alice = Person.new('Alice')
bob = Person.new('Bob')

logger.info("Iniciando a comunicação...")

print "\n"

alice.public_key, alice.private_key = ca.generate_keys
bob.public_key, bob.private_key = ca.generate_keys

logger.info("AC: Chaves públicas e privadas distribuídas para ALICE e BOB")

print "\n"

logger.info("ALICE: minha chave pública é: #{alice.public_key}")
logger.debug("ALICE private: #{alice.private_key}")

print "\n"

logger.info("BOB: minha chave pública é: #{bob.public_key}")
logger.debug("BOB private: #{bob.private_key}")

print "\n"

## Assinatura digital de Alice

logger.info("ASSINATURA DIGITAL DA ALICE")

ds = RSA::DigitalSignature.new('Oi, eu sou a Alice', alice.private_key)
alice_signature_pack = ds.signature_pack
ds.valid?(alice_signature_pack[:message], alice_signature_pack[:signature], alice.public_key)

print "\n"

logger.info("ASSINATURA DIGITAL DO BOB")

ds = RSA::DigitalSignature.new('Oi, eu sou o Bob', bob.private_key)
bob_signature_pack = ds.signature_pack
ds.valid?(bob_signature_pack[:message], bob_signature_pack[:signature], bob.public_key)

## ALICE -> BOB

print "\n"

logger.info("Digite a mensagem que ALICE enviará para BOB:")
original_message = gets.chomp

print "\n"

logger.info("ALICE quer mandar a mensagem '#{original_message}' para BOB")

logger.info("ALICE cifra a mensagem usando a chave pública de BOB")
ciphed_message = rsa.encrypt(original_message, bob.public_key)

logger.info("ALICE envia '#{ciphed_message}' para BOB")

print "\n"

logger.info("BOB recebe '#{ciphed_message}' de ALICE")

logger.info("BOB decifra a mensagem usando a sua chave privada")
deciphed_message = rsa.decrypt(ciphed_message, bob.private_key)
logger.info("BOB lê a mensagem decifrada: '#{deciphed_message}'")

## BOB -> ALICE

print "\n"

logger.info("Digite a mensagem que BOB enviará para ALICE:")
original_message = gets.chomp

print "\n"

logger.info("BOB quer mandar a mensagem '#{original_message}' para ALICE")

logger.info("BOB cifra a mensagem usando a chave pública de ALICE")
ciphed_message = rsa.encrypt(original_message, alice.public_key)

logger.info("BOB envia '#{ciphed_message}' para ALICE")

print "\n"

logger.info("ALICE recebe '#{ciphed_message}' de BOB")

logger.info("ALICE decifra a mensagem usando a sua chave privada")
deciphed_message = rsa.decrypt(ciphed_message, alice.private_key)
logger.info("ALICE lê a mensagem decifrada: '#{deciphed_message}'")

