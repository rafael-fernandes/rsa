## Criptografia RSA

A criptografia RSA utiliza um par de chaves pública e privada para encriptar e desencriptar mensagens.

### 1. Geração de chaves

1. Escolhe-se dois primos `p e q`
2. Calcula-se `n = p * q`
3. Calcula-se `phi(n) = (p - 1) * (q - 1)`
4. Calcula-se (parte da chave pública) `e = x | 1 < x < phi(n) e x % phi(n) != 0`
5. Calcula-se (parte da chave privada) `d = inverso multiplicativo de e mod phi(n)`
6. Par de chaves será pública `(e, n)` e privada `(d, n)`

### 2. Encriptação

Para encriptar utiliza-se a chave pública (e, n): 

```
mensagem ** e mod n
```

### 3. Desencriptação

Para encriptar utiliza-se a chave pública (e, n): 

```
mensagem_cifrada ** d mod n
```

### Assinatura digital

A assinatura digital é uma forma de garantir autenticidade no envio de uma mensagem.

1. Define-se uma mensagem.
2. Calcula-se o bloco autenticador (hash da mensagem).
3. Encripta o hash utilizadno a chave privada do transmissor.
4. Envia-se `{ mensagem, assinatura_digital }` para o receptor.
5. O receptor desencripta a assinatura digital utilizando a chave pública do transmissor.
6. Calcula-se o hash da mensagem recebida.
7. Se os hashs forem iguais, então o receptor é quem ele diz ser.

### API:

#### Geração de chaves

```ruby
alice.public_key, alice.private_key = CA.new.generate_keys
# [{ n: 1363, e: 1283 }, { n: 1363, d: 515 }]
```

#### Encriptação

```ruby
ciphed_message = RSA.new.encrypt('Segurança Computacional - UnB 2/2019', alice.public_key)
# '1350 606 459 1190 19 852 384 550 852 153 818 112 270 712 1190 1218 852 1032 60 112 384 852 392 153 633 153 1092 384 681 153 711 611 711 424 777 608'
```

#### Desencriptação

```ruby
deciphed_message = RSA.new.decrypt('1350 606 459 1190 19 852 384 550 852 153 818 112 270 712 1190 1218 852 1032 60 112 384 852 392 153 633 153 1092 384 681 153 711 611 711 424 777 608', alice.private_key)
# Segurança Computacional - UnB 2/2019
```

#### Assinatura digital

```ruby
ds = RSA::DigitalSignature.new('Oi, eu sou a Alice', alice.private_key)

alice_signature_pack = ds.signature_pack
# ['Oi, eu sou a Alice', '3DE 354 41C 518 3A7 2E9 3A7 D5 162 2E9 300 D5 1E8 2E9 2E9 3A7 41C 54 1FE 3DE 1E8 300 237 2E9 518 1FE 1E8 237 3A7 2E9 2E9 3A2 D5 2E9 54 1E8 41C 1FE D5 D5']

ds.valid?(alice_signature_pack[:message], alice_signature_pack[:signature], alice.public_key)
# ℹ info    Mensagem: 'Oi, eu sou a Alice'
# ✔ success Hash da mensagem: d8e9141b347b6441e2cd67549c65144ab426ecbb
# ℹ info    Assinatura digital: 3DE 354 41C 518 3A7 2E9 3A7 D5 162 2E9 300 D5 1E8 2E9 2E9 3A7 41C 54 1FE 3DE 1E8 300 237 2E9 518 1FE 1E8 237 3A7 2E9 2E9 3A2 D5 2E9 54 1E8 41C 1FE D5 D5
# ✔ success Assinatura digital decifrada: d8e9141b347b6441e2cd67549c65144ab426ecbb
# ✔ success Os hashs são iguais
```

**Fontes:**
* [RSA Express Encryption/Decryption Calculator](https://www.cs.drexel.edu/~jpopyack/Courses/CSP/Fa17/notes/10.1_Cryptography/RSA_Express_EncryptDecrypt_v2.html)