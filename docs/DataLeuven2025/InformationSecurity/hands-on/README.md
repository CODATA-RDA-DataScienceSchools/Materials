# Introduction and Main Concepts

GPG, also known as GNU Privacy Guard, is a software that implements public key cryptography. It enables the safe exchange of data between different parties and ensures the authenticity of messages.

This tutorial will delve into the functioning and implementation of GPG. While our demonstration will focus on an Ubuntu server. 

Numerous users encounter the challenge of ensuring secure communication and confirming the identity of the other party in a conversation. Several solutions addressing this concern often involve the exchange of passwords or identifying credentials, which must be done through an unsecured channel, adding to the problem.

To address this challenge, GPG relies on the security concept of public key encryption. The fundamental idea is to separate the encryption and decryption stages of data transmission into distinct components. Consequently, the encrypting part can be freely shared, while the decrypting part must be kept secure.

This approach facilitates a one-way message transfer, where anyone can create and encrypt messages, but only the intended recipient (possessing the private decryption key) can decrypt them. If both parties generate public/private key pairs and exchange their public encryption keys, they can encrypt messages for each other.

Thus, each party has its private key and the other user's public key in this scenario.

Additionally, this system allows the sender to "sign" a message with their private key, offering the advantage of validating the sender's identity through the public key possessed by the receiver.

For any further assistance on GNUpg, check their [website](https://gnupg.org/index.html).

# Generating a Key

GPG is installed by default in most distributions.

⚠️⚠️⚠️ **For this lab session there is no need to install gpg, because it has already been installed** ⚠️⚠️⚠️

If you are using a machine that, for any reason, GPG is not installed, on Ubuntu and Debian, you can update the local repo index and install it by typing:

```bash!
$ sudo apt update
$ sudo apt install gnupg
```

We can check if it is installed by running the command: 

```bash!
$ gpg --version
```
The output should be similar to this:
```bash!
gpg (GnuPG) 2.2.19
libgcrypt 1.8.5
Copyright (C) 2019 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
...
```

In order to start using the GNUpg you must first create a new keypair:

```bash!
$ gpg --gen-key
```

The key is stored in an special databased placed at `${HOME}/.gnupg/trustdb.gpg`. 

⚠️⚠️⚠️ Remember that the `${HOME}` variable points to your user home directory. It could be something like `/home/john`, considering that your username is _john_. Throughout this tutorial you can change the username _john_ to your own username. ⚠️⚠️⚠️

During the generation you should provide the user name and email address:

```bash!
gpg: directory '/home/john/.gnupg' created
gpg: keybox '/home/john/.gnupg/pubring.kbx' created
Note: Use "gpg --full-generate-key" for a full featured key generation dialog.

GnuPG needs to construct a user ID to identify your key.

Real name: John Doe
Email address: john@doe.com
You selected this USER-ID:
    "John Doe<john@doe.com>"

Change (N)ame, (E)mail, or (O)kay/(Q)uit? O
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
gpg: /home/john/.gnupg/trustdb.gpg: trustdb created
gpg: key DCEEF79B91A8A2BC marked as ultimately trusted
gpg: directory '/home/john/.gnupg/openpgp-revocs.d' created
gpg: revocation certificate stored as '/home/john/.gnupg/openpgp-revocs.d/0B02D50E37F5C9D6A4678200DCEEF79B91A8A2BC.rev'
public and secret key created and signed.

pub   rsa3072 2023-08-06 [SC] [expires: 2025-08-05]
      0B02D50E37F5C9D6A4678200DCEEF79B91A8A2BC
uid                      John Doe <john@doe.com>
sub   rsa3072 2023-08-06 [E] [expires: 2025-08-05]

```

Now we can list the public keys installed in our keyring by typing the command: 

```bash!
$ gpg --list-keys 

gpg: checking the trustdb
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
gpg: next trustdb check due at 2025-08-05
/home/john/.gnupg/pubring.kbx
------------------------------
pub   rsa3072 2023-08-06 [SC] [expires: 2025-08-05]
      0B02D50E37F5C9D6A4678200DCEEF79B91A8A2BC
uid           [ultimate] John Doe <john@doe.com>
sub   rsa3072 2023-08-06 [E] [expires: 2025-08-05]

```

Remember that the keys we've been using in this tutorial are asymmetric, so we can also list the private keys installed in our system with the command: 

```bash!
$ gpg --list-secret-keys 
/home/john/.gnupg/pubring.kbx
------------------------------
sec   rsa3072 2023-08-06 [SC] [expires: 2025-08-05]
      0B02D50E37F5C9D6A4678200DCEEF79B91A8A2BC
uid           [ultimate] John Doe <john@doe.com>
ssb   rsa3072 2023-08-06 [E] [expires: 2025-08-05]

```

We can also add the `--keyid-format short` switch to get a better output.

The whole idea of having the asymmetric cryptography is that we will **exchange keys**, but be warned that **you must only send your public keys** for another person.

# Exporting your keys
In order to export your public key you must run:
```bash!
$$ gpg --output my_key.asc --armor --export john@doe.com
```
This command will generate a text file with the content similar to this:
```bash!
-----BEGIN PGP PUBLIC KEY BLOCK-----

mQENBE55CJIBCACkn+aOLmsaq1ejUcXCAOXkO3w7eiLqjR/ziTL2KZ30p7bxP8cT
UXvfM7fwE7EnqCCkji25x2xsoKXB8AlUswIEYUFCOupj2BOsVmJ/rKZW7fCvKTOK
+BguKjebDxNbgmif39bfSnHDWrW832f5HrYmZn7a/VySDQFdul8Gl/R6gs6PHJbg
jjt+K7Px6cQVMVNvY/VBWdvA1zckO/4h6gf3kWWZN+Wlq8wv/pxft8QzNFgweH9o
5bj4tnQ+wMCLCLiDsgEuVawoOAkg3dRMugIUoiKoBKw7b21q9Vjp4jezRvciC6Ys
4kGUSFG1ZjIn3MpY3f3xZ3yuYwrxQ8JcA7KTABEBAAG0JExpbnVzIFRvcnZhbGRz
IDx0b3J2YWxkc0BrZXJuZWwub3JnPokBTgQTAQgAOBYhBKuvEcZaKXCxMKvjxHm+
PkMAQRiGBQJaHxkTAhsDBQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEHm+PkMA
QRiGzMcH/ieyxrsHR0ng3pi+qy1/sLiTT4WEBN53+1FsGWdP6/DCD3sprFdWDkkB
Dfh9vPCVzPqX7siZMJxw3+wOfjNnGBRiGj7mTE/1XeXJHDwFRyBEVa/bY8ExLKbv
Bf+xpiWOg2Myj5RYaOUBFbOEtfTPob0FtvfZvK3PXkjODTHhDH7QJT2zNPivHG+E
R5VyF1yJEpl10rDTM91NhEeV0n4wpfZkgL8a3JSzo9H2AJX3y35+Dk9wtNge440Z
SVWAnjwxhBLX2R0LUszRhU925c0vP2l20eFncBmAT0NKpn7v9a670WHv45PluG+S
KKktf6b5/BtfqpC3eV58I6FEtSVpM1u5AQ0ETnkIkgEIAN+ybgD0IlgKRPJ3eksa
fd+KORseBWwxUy3GH0yAg/4jZCsfHZ7jpbRKzxNTKW1kE6ClSqehUsuXT5Vc1eh6
079erN3y+JNxl6zZPC9v+5GNyc28qSfNejt4wmwa/y86T7oQfgo77o8Gu/aO/xzO
jw7jSDDR3u9p/hFVtsqzptxZzvs3hVaiLS+0mar9qYZheaCUqOXOKVo38Vg5gkOh
MEwKvZs9x3fINU/t8ckxOHq6KiLap5Bq87XP0ZJsCaMBwdLYhOFxAiEVtlzwyo3D
vMplIahqqNELb71YDhpMq/Hu+42oR3pqASCPLfO/0GUSdAGXJVhv7L7ng02ETSBm
VOUAEQEAAYkBHwQYAQIACQUCTnkIkgIbDAAKCRB5vj5DAEEYhuobB/9Fi1GVG5qn
Pq14S0WKYEW3N891L37LaXmDh977r/j2dyZOoYIiV4rx6a6urhq9UbcgNw/ke01T
NM4y7EhW/lFnxJQXSMjdsXGcb9HwUevDk2FMV1h9gkHLlqRUlTpjVdQwTB9wMd4b
WhZsxybTnGh6o8dCwBEaGNsHsSBYO81OXrTE/fcZEgKCeKW2xdKRiazu6Mu5WLU6
gBy2nOc6oL2zKJZjACfllQzBx5+6z2N4Sj0JBOobz4RR2JLElMEckMbdqbIS+c+n
02ItMmCORgakf74k+TEbaZx3ZTVHnhvqQqanZz1i4I5IwHJxkUsYLddgYrylZH+M
wNDlB5u3I138
=RrrU
-----END PGP PUBLIC KEY BLOCK-----
```

You can also create a backup of your private key by running the following command:

```bash!
$ gpg --output my_key.asc --armor --export-secret-key john@doe.com
```
The content of the private key will be very similar to the content of the public key.


# Importing a Public Key to your trusted database

We will query this database anytime we want to encrypt a message or a file with another user's public key. In our scenario, in order to add the (public) key from [Linus Torvalds](https://en.wikipedia.org/wiki/Linus_Torvalds) to our database.
First we will need to download his public key file. For commodity, this has been made available at this [link](https://www.dropbox.com/scl/fi/uqli7rbbinivxub3rqi1m/linus_torvalds.asc?rlkey=4iyedp5ol8gieslkgqb6417do&st=z0hm0iis&dl=0). Assuming that you have downloaded the link into a file named `linus_torvalds.asc` we will run the following command for importing the **public key**:

```bash!
$ gpg --import linus_torvalds.asc

gpg: key 79BE3E4300411886: public key "Linus Torvalds <torvalds@kernel.org>" imported
gpg: Total number processed: 1
gpg:               imported: 1

```

We can also query public pgp key servers, for instance, the [MIT](https://pgp.mit.edu/), the [OpenPGP](https://keys.openpgp.org/), or the [Ubuntu](http://keyserver.ubuntu.com:11371/) servers. In order to do so, one must run (you can import keys that you find by following the prompts): 

```bash!
$ gpg --keyserver keys.openpgp.org  --search-keys "raphaelmcobe@gmail.com"

gpg: data source: http://keys.openpgp.org:11371
(1)	Raphael Cobe <raphael.cobe@advancedinstitute.ai>
	Raphael Cobe <raphael.cobe@cern.ch>
	Raphael Cobe <raphael.cobe@sprace.org.br>
	Raphael Cobe <raphael.cobe@unesp.br>
	Raphael Cobe <raphaelmcobe@DOMAIN.com>
	  3072 bit RSA key 95A5F3806ED44AE1, created: 2023-08-06
Keys 1-1 of 1 for "raphaelmcobe@gmail.com".  Enter number(s), N)ext, or Q)uit >
```

After selecting one of the results, your keyring should look more or less like this:

```bash!
$ gpg --list-keys --keyid-format short
/home/john/.gnupg/pubring.kbx
--------------------------------------------------
pub   rsa3072/6267B8C5 2024-08-19 [SC] [expires: 2026-08-19]
      C23E66D5AAE6AD77460795E75138ECAB6267B8C5
uid         [ultimate] John Doe <john@doe.com>
sub   rsa3072/EFD5CB2D 2024-08-19 [E] [expires: 2026-08-19]

pub   rsa2048/00411886 2011-09-20 [SC]
      ABAF11C65A2970B130ABE3C479BE3E4300411886
uid         [ unknown] Linus Torvalds <torvalds@kernel.org>
sub   rsa2048/012F54CA 2011-09-20 [E]

pub   rsa3072/6ED44AE1 2023-08-06 [SC] [expires: 2025-08-05]
      2AE07E9C06A5B01886A38CB795A5F3806ED44AE1
uid         [ unknown] Raphael Cobe <raphael.cobe@sprace.org.br>
uid         [ unknown] Raphael Cobe <raphael.cobe@advancedinstitute.ai>
uid         [ unknown] Raphael Cobe <raphael.cobe@cern.ch>
uid         [ unknown] Raphael Cobe <raphael.cobe@unesp.br>
uid         [ unknown] Raphael Cobe <raphaelmcobe@gmail.com>
sub   rsa3072/8773B1FF 2023-08-06 [E] [expires: 2025-08-05]
```

## Checking authenticity of a public key

Determining the authenticity of the person providing you with their public key can be a challenge. In certain situations, it might be straightforward, such as when you are physically present together, exchanging keys with laptops open. This method is quite secure and ensures you receive the correct and legitimate key.

However, there are numerous instances where such direct contact is not feasible. Perhaps you don't know the other party personally or are separated by distance. In such cases, verifying the public key's authenticity without resorting to insecure channels can be difficult.

Fortunately, there is a solution that doesn't involve verifying the entire public keys of both parties. Instead, you can compare the "fingerprint" derived from these keys, which provides a reasonable level of assurance that both parties are using the same public key information.

To obtain the fingerprint of a public key, follow these steps: 

```bash!
$ gpg --fingerprint "John Doe"
pub   rsa3072 2023-08-06 [SC] [expires: 2025-08-05]
      0B02 D50E 37F5 C9D6 A467  8200 DCEE F79B 91A8 A2BC
uid           [ultimate] John Doe <john@doe.com>
sub   rsa3072 2023-08-06 [E] [expires: 2025-08-05]

```

You can also extract the fingerprint from a public key on a file: 

```bash!
$ $ gpg --show-keys --fingerprint linus_torvalds.asc 
pub   rsa2048 2011-09-20 [SC]
      ABAF 11C6 5A29 70B1 30AB  E3C4 79BE 3E43 0041 1886
uid                      Linus Torvalds <torvalds@kernel.org>
sub   rsa2048 2011-09-20 [E]
```

## Signing someone else's key

Signing a key serves as an indication of your trust in the provided key and confirms that you have verified its association with the individual in question.

To sign a key that you have imported. In our scenario if john were to sign Linus's key, the user needs to execute the following command:

```bash!
$ $ gpg --sign-key torvalds@kernel.org 

pub  rsa2048/79BE3E4300411886
     created: 2011-09-20  expires: never       usage: SC  
     trust: unknown       validity: unknown
sub  rsa2048/88BCE80F012F54CA
     created: 2011-09-20  expires: never       usage: E   
[ unknown] (1). Linus Torvalds <torvalds@kernel.org>


pub  rsa2048/79BE3E4300411886
     created: 2011-09-20  expires: never       usage: SC  
     trust: unknown       validity: unknown
 Primary key fingerprint: ABAF 11C6 5A29 70B1 30AB  E3C4 79BE 3E43 0041 1886

     Linus Torvalds <torvalds@kernel.org>

Are you sure that you want to sign this key with your
key "John Doe <john@doe.com>" (5138ECAB6267B8C5)

Really sign? (y/N) y
```

By signing the key, you express your confidence in the person's claimed identity, helping others make a decision about trusting that individual as well. If someone trusts you and notices that you have signed this person's key, they may be more inclined to trust their identity too.

A few words about the web of trust principle:

The Web of Trust is a decentralized trust model used in the PGP (Pretty Good Privacy) protocol to authenticate the identities of public key holders without relying on a central authority. In this system, trust is established through endorsements from other users. When a user verifies another's public key and is confident in their identity, they can sign that key, creating a trust relationship. This signature is a form of endorsement, indicating that the signer trusts that the key belongs to the person it claims to. As more signatures are added, a web of trust is formed, where the trustworthiness of a key can be evaluated based on the number and quality of endorsements it has received from other trusted users. This approach allows users to build a network of trust relationships, making it harder for an attacker to impersonate someone without widespread detection.

![image](https://hackmd.io/_uploads/SyUyAGgsA.png)



Allowing the person whose key you are signing to benefit from your trusted relationship involves sending them back the signed key. First, let's sign my public key with the _John Doe_ user:

```bash=
$ gpg --sign-key raphaelmcobe@gmail.com 

pub  rsa3072/95A5F3806ED44AE1
     created: 2023-08-06  expires: 2025-08-05  usage: SC  
     trust: unknown       validity: unknown
sub  rsa3072/E13FFB678773B1FF
     created: 2023-08-06  expires: 2025-08-05  usage: E   
[ unknown] (1). Raphael Cobe <raphael.cobe@sprace.org.br>
[ unknown] (2)  Raphael Cobe <raphael.cobe@advancedinstitute.ai>
[ unknown] (3)  Raphael Cobe <raphael.cobe@cern.ch>
[ unknown] (4)  Raphael Cobe <raphael.cobe@unesp.br>
[ unknown] (5)  Raphael Cobe <raphaelmcobe@gmail.com>

Really sign all user IDs? (y/N) y

pub  rsa3072/95A5F3806ED44AE1
     created: 2023-08-06  expires: 2025-08-05  usage: SC  
     trust: unknown       validity: unknown
 Primary key fingerprint: 2AE0 7E9C 06A5 B018 86A3  8CB7 95A5 F380 6ED4 4AE1

     Raphael Cobe <raphael.cobe@sprace.org.br>
     Raphael Cobe <raphael.cobe@advancedinstitute.ai>
     Raphael Cobe <raphael.cobe@cern.ch>
     Raphael Cobe <raphael.cobe@unesp.br>
     Raphael Cobe <raphaelmcobe@gmail.com>

This key is due to expire on 2025-08-05.
Are you sure that you want to sign this key with your
key "John Doe <john@doe.com>" (5138ECAB6267B8C5)

Really sign? (y/N) y
```

Then, now we can export the signed public key and send it to the owner:


```bash!
$ gpg --output raphael_cobe_key.asc --armor --export raphaelmcobe@gmail.com
```
The `--armor` switch tells the `gpg` command line to generate ASCII outputs.

In order to list the signatures of Riley's public key, one should run:

```bash!
$ $ gpg --list-signatures "Raphael Cobe"
pub   rsa3072 2023-08-06 [SC] [expires: 2025-08-05]
      2AE07E9C06A5B01886A38CB795A5F3806ED44AE1
uid           [  full  ] Raphael Cobe <raphael.cobe@sprace.org.br>
sig 3        95A5F3806ED44AE1 2023-08-06  Raphael Cobe <raphael.cobe@sprace.org.br>
sig          5138ECAB6267B8C5 2024-08-19  John Doe <john@doe.com>
uid           [  full  ] Raphael Cobe <raphael.cobe@advancedinstitute.ai>
sig 3        95A5F3806ED44AE1 2023-08-06  Raphael Cobe <raphael.cobe@sprace.org.br>
sig          5138ECAB6267B8C5 2024-08-19  John Doe <john@doe.com>
uid           [  full  ] Raphael Cobe <raphael.cobe@cern.ch>
sig 3        95A5F3806ED44AE1 2023-08-06  Raphael Cobe <raphael.cobe@sprace.org.br>
sig          5138ECAB6267B8C5 2024-08-19  John Doe <john@doe.com>
uid           [  full  ] Raphael Cobe <raphael.cobe@unesp.br>
sig 3        95A5F3806ED44AE1 2023-08-06  Raphael Cobe <raphael.cobe@sprace.org.br>
sig          5138ECAB6267B8C5 2024-08-19  John Doe <john@doe.com>
uid           [  full  ] Raphael Cobe <raphaelmcobe@gmail.com>
sig 3        95A5F3806ED44AE1 2023-08-06  Raphael Cobe <raphael.cobe@sprace.org.br>
sig          5138ECAB6267B8C5 2024-08-19  John Doe <john@doe.com>
sub   rsa3072 2023-08-06 [E] [expires: 2025-08-05]
sig          95A5F3806ED44AE1 2023-08-06  Raphael Cobe <raphael.cobe@sprace.org.br>
```

In the lines: 
```bash!
uid           [  full  ] Raphael Cobe <raphaelmcobe@gmail.com>
sig 3        95A5F3806ED44AE1 2023-08-06  Raphael Cobe <raphael.cobe@sprace.org.br>
sig          5138ECAB6267B8C5 2024-08-19  John Doe 
```
One can see that the public key has been signed by the owner of the key and by _john_.

Now that the user's key has been signed by *john*, the keys from can be updated:

```bash!
$ gpg --import raphael_cobe_key.asc
```

# Publish your private key to a keyserver

The design of public key encryption ensures that there is no potential for malicious actions even if unknown individuals possess your public key.

Considering this, it can be advantageous to openly share your public key, as it allows people to access your information and communicate with you securely right from the outset.

In our scenario, if the *john* user wants to provide a public key to anyone, simply request it from the GPG system: 

```bash!
$ gpg --output ~/mygpg.key --armor --export john@doe.com

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.4.11 (GNU/Linux)

mQINBFJPCuABEACiog/sInjg0O2SqgmG1T8n9FroSTdN74uGsRMHHAOuAmGLsTse
9oxeLQpN+r75Ko39RVE88dRcW710fPY0+fjSXBKhpN+raRMUKJp4AX9BJd00YA/4
EpD+8cDK4DuLlLdn1x0q41VUsznXrnMpQedRmAL9f9bL6pbLTJhaKeorTokTvdn6
5VT3pb2o+jr6NETaUxd99ZG/osPar9tNThVLIIzG1nDabcTFbMB+w7wOJuhXyTLQ
JBU9xmavTM71PfV6Pkh4j1pfWImXc1D8dS+jcvKeXInBfm2XZsfOCesk12YnK3Nc
u1Xe1lxzSt7Cegum4S/YuxmYoh462oGZ7FA4Cr2lvAPVpO9zmgQ8JITXiqYg2wB3
. . .
```

Most of the pgp key servers will have an interface that allows to upload the public key. An alternative is to use it directly from the command line. First we have to discover the key id. So, first we have to list the key:

```bash!
$ gpg --list-keys --keyid-format short john@doe.com

pub   rsa3072/91A8A2BC 2023-08-06 [SC] [expires: 2025-08-05]
      0B02D50E37F5C9D6A4678200DCEEF79B91A8A2BC
uid         [ultimate] John Doe <john@doe.com>
sub   rsa3072/C8149F9C 2023-08-06 [E] [expires: 2025-08-05]
```

In this example, the short id for the *john* user is the code `91A8A2BC`. Then, in order to perform the upload, *john* will have to run: 

```bash!
$ gpg --send-keys --keyserver keys.openpgp.org 91A8A2BC
gpg: sending key DCEEF79B91A8A2BC to hkp://keys.openpgp.org
```

In the case of the OpenPGP server, it will send you an email in order to validate the email address on the key. You need to follow its instructions in order to get your key published at the server.


# Encrypting and Decrypting a message using the PGP protocol


To encrypt messages using GPG, you can use the "--encrypt" flag along with other options. In our example, if the user *john* wants to send Linus Torvald's an encrypted message or file (`file.txt`), the command to run would be:

```bash!
gpg --encrypt --sign --armor -r torvalds@kernel.org file.txt
```

This command performs the following actions: It encrypts the message using Linus' public key, signs it with *john's* private key to verify its origin, and presents the output in a text format rather than raw bytes. The resulting filename will be the same as the input filename, but with– a .asc extension.

If the user *john* wishes to also read the encrypted message, remember to include a second "-r" with your own email address (e.g., `-r john@doe.com`). This is necessary because the message will be encrypted with each recipient's public key and can only be decrypted using the corresponding private key.

By adding yourself as a second recipient, the message is encrypted twice – once for each recipient. This ensures that you can decrypt and view the message, and it also offers an additional layer of security in case you need to access it later. Without your own email address as a recipient, you would be unable to read the message again unless you somehow obtained the other party's private key.

Now we can inspect what is the encrypted file format and its content:

```bash!
$ file file.txt.asc 
file.txt.asc: PGP message Public-Key Encrypted Session Key

$cat file.txt.asc
-----BEGIN PGP MESSAGE-----

hQGMA193Lu/0v60jAQwAly4IhJtXf65qnvts4qZv93Uaf1PZU0cV78otjAAvQRF6
aLeMCuAHrQ/CG3R8tjF34F9oMcobFs2+5A8x1hBuggP2RlF9hYl5DfAPBqYp0qgj
EvC2kPxYiyCtLlTe2R2YWVm0u8xmJL8gc2VlioYU+xvWkpSz+82VKc7QelJtM6Js
bnoxwoCUn9myCPTHIy0OPXgKJVsSh+9p5Ru3/5PxaZ3XiBjWHtOSKIyTsEp5QhvC
qu/zxxosDCGMxLgkiWPoW6NIKqMQSoIzUns6MuuWjE8GNDVQEIMVdFN4FvMKeiNj
FJui2jZu3HrJ/qEoaS9WCB508SZ0+3UvzxUMA5lXR3ciUjKzEIXzHwsi/PyxPKE4
VSedOtzVbL56utA+UmWeufd5oQzdzW+aQsPvcZOVtH6iQmzvfZxkBdlTWZ1Nlrdw
iQRi8H98D/imuV5S3R48qDXUAr6AkOsJs63vwOaU3fTxZ1cidsdWwtx40Ksa0k0q
pswab18H2V5Cckxvsic10ukBn8CDFAdveuZwBL3Zvjr7+rXkY4n/TmqupRnhsvV/
anZ+5NJ3lWr+r1TIjvpENZFtZGwtiS28k58H45y4Td/GJw2gxoBmY6zed6bYuQK9
cqtajt3HHJzqXamAMXaaTDLxJIXW5+Cl3CDeFKnoC9jq+W8tOB4TcJipSGULFueU
0E39O98Do/3ZFfq+NrusN3DWKWQTlaWhwBmJ8IDhIVOR5vp0LF2AUJH/mXyenq7k
/eBSkqUgo+K+mp8efKkVN9p8x0xvxqEYq5IHpABwjQY6j7Ljff0pelxzeE1mIKnX
h4BFMUeH9xXKDezpbONrcnGMx0K7001uX6hQQcwDX1zYAL0sHCej8XamuYcJjn0Q
JoZ4IEMFm73+PXrndWxBwNj1//6YklY6i7PnNj0focxscAhCCEaiZaRpH/9so6tl
ChLS0MFUmHdBmGatMKB98btB863We6BN+w0gt/sBe/ttpWEt2wNeURlJIHGjLGYx
vBn2yd+VIrcjhYBYVQxHLz/h1pEg7uOOuavHN4k/0vcJvNa2nCvpLq0vGTtTxvFd
RB2mYdHpRZFcjJJGl25TwX3OtBztxv2YPWEULOtv7+YCYh87iOCKw2+IXNCTmxe7
YaBbqDRhafBw6Wvw8SpZuY1k6ctP/2y4ZBOIZrcrQ3bceLh2hS8Zm42RIpt0W7An
TRs/x5KEtlqicc9Kpx9uHmhPkPyamRlM59ADFp4=
=OJji
-----END PGP MESSAGE-----

```

Now *john* can send the encrypted msg to Linus and be sure that he will be the only one able to read the message. In order to do so, Linus Torvald's would run the following command:

```bash!
$ $ gpg --decrypt --output file.txt file.txt.asc 

gpg: encrypted with 3072-bit RSA key, ID 4BE971D7C39C0E68, created 2024-08-19
      "Linus Torvalds <torvalds@kernel.org>"
File 'file.txt' exists. Overwrite? (y/N) 
Enter new filename: decrypted.txt
gpg: Signature made Mon 19 Aug 2024 04:04:15 AM CEST
gpg:                using RSA key C23E66D5AAE6AD77460795E75138ECAB6267B8C5
gpg: Good signature from "John Doe <john@doe.com>" [ultimate]
```
Now we check the content of the file:
```bash!
$ cat decrypted.txt 

This is a very secret file
```

The `Good signature from` statement states that the file hasn't been altered since it was encrypted and signed. In order to avoid opening messages from untrusted users, make sure that you know the sender and once you have access to a secure copy of their security key, sign it.

## Generate separate signature file

In order to verify that the content of the file hasn't been altered, one can create a separate signature file by performing the following command: 

```bash!
$ gpg --output file.txt.sig --detach-sig file.txt
```

Now it is possible to verify that the content of the file hasn't changed:

```bash!
$ gpg --verify file.txt.sig file.txt
gpg: Signature made dom 06 ago 2023 20:31:41 -03
gpg:                using RSA key 0B02D50E37F5C9D6A4678200DCEEF79B91A8A2BC
gpg: Good signature from "John Doe <john@doe.com>" [full]
```

If the file has been altered the message will look like:

```bash!
$ gpg --verify file.txt.sig file.txt
gpg: Signature made dom 06 ago 2023 20:31:41 -03
gpg:                using RSA key 0B02D50E37F5C9D6A4678200DCEEF79B91A8A2BC
gpg: BAD signature from "John Doe <john@doe.com>" [full]
```

Also, if the identity of the signee can't be verifyied, i.e., we don't have access to the public key, we will see the following message: 

```bash!
$ gpg --verify file.txt.sig file.txt
gpg: Signature made dom 06 ago 2023 20:31:41 -03
gpg:                using RSA key 0B02D50E37F5C9D6A4678200DCEEF79B91A8A2BC
gpg: Can't check signature: No public key
```




# Verify Downloaded Software

We can also use the signature file to check the integrity and authorship of software we download from the internet. For instance, let's check the [VeraCrypt](https://veracrypt.fr/en/Downloads.html) tool.

![image](https://hackmd.io/_uploads/BkYsFXejC.png)


We need to download both the signature file and the veracrypt [public key](https://www.idrix.fr/VeraCrypt/VeraCrypt_PGP_public_key.asc). **Be sure to download the real key from Veracrypt!!**

Inspect the key just downloaded and include it to you keychain:

```bash!
$gpg --show-keys VeraCrypt_PGP_public_key.asc 

pub   rsa4096 2018-09-11 [SC]
      5069A233D55A0EEB174A5FC3821ACD02680D16DE
uid                      VeraCrypt Team (2018 - Supersedes Key ID=0x54DDD393) <veracrypt@idrix.fr>
sub   rsa4096 2018-09-11 [E]
sub   rsa4096 2018-09-11 [A]

$ gpg --import VeraCrypt_PGP_public_key.asc

```

Alternatively we can download and import the key from the OpenPGP server:

```bash!
$ gpg --keyserver keys.openpgp.org --search-keys veracrypt@idrix.fr

gpg: data source: http://keys.openpgp.org:11371
(1)	VeraCrypt Team (2018 - Supersedes Key ID=0x54DDD393) <veracrypt@idrix.
	  4096 bit RSA key 821ACD02680D16DE, created: 2018-09-11
Keys 1-1 of 1 for "veracrypt@idrix.fr".  Enter number(s), N)ext, or Q)uit > 1

gpg: key 821ACD02680D16DE: public key "VeraCrypt Team (2018 - Supersedes Key ID=0x54DDD393) <veracrypt@idrix.fr>" imported
gpg: Total number processed: 1
gpg:               imported: 1

```

After importing the key, we have to state that we trust this key. We do that by signing the key:

```bash!
$ gpg --sign-key veracrypt@idrix.fr
```

The key id can also be used and it can be obtained using the `gpg --list-keys --keyid-format short`


Now we can check the integrity of the package against the signature file:

```bash!
$ $ gpg --verify veracrypt-console-1.26.7-Ubuntu-24.04-amd64.deb.sig veracrypt-console-1.26.7-Ubuntu-24.04-amd64.deb
gpg: Signature made Mon 20 May 2024 10:13:47 PM CEST
gpg:                using RSA key 5069A233D55A0EEB174A5FC3821ACD02680D16DE
gpg: checking the trustdb
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   3  signed:   3  trust: 0-, 0q, 0n, 0m, 0f, 3u
gpg: depth: 1  valid:   3  signed:   0  trust: 3-, 0q, 0n, 0m, 0f, 0u
gpg: next trustdb check due at 2025-08-05
gpg: Good signature from "VeraCrypt Team (2018 - Supersedes Key ID=0x54DDD393) <veracrypt@idrix.fr>" [full]

```

The **Good signature from "VeraCrypt Team (2018 - Supersedes Key ID=0x54DDD393) <veracrypt@idrix.fr>"** statement makes clear that the package integrity was checked.



# Exercises

1. If you haven't done it yet, create your private key;
2. Collect as many signatures as possible from you coleagues
    * You can add you key to the [link](https://drive.google.com/drive/folders/1z5UMskD5PmKyfFfqSWpbK7n-obwDB0kz?usp=sharing) with the name `YOUR_FIRST_NAME_pub`, then, sign as many keys as you can and reupload the keys with the name `SOMEONE_FIRST_NAME_signed_YOUR_FIRST_NAME_pub`, e.g, a user name john includes the file `john_pub`, than another user named mary signs John's key and reupload it with the name`john_signed_mary_pub`.
3. Upload your key to the `openpgp` key server;
4. Pair with other students and exchange encrypted messages among yourselves;
5. Don't forget to export your private key to take home with you; Use this [link](https://itslinuxfoss.com/export-gpg-private-key-and-public-key-file/#:~:text=To%20export%20a%20GPG%20private%20and%20public%20key%20to%20a,%E2%80%93list%2Dkeys%E2%80%9D%20command.) as reference;
6. Check the integrity of the [Tixati torrent client](https://www.tixati.com/download/linux.html) program;
7. What is a Revocation key? Why is it important to have one?
    * Read this [blog post](https://blog.chapagain.com.np/gpg-revoking-your-public-key-and-notifiying-key-server/).

