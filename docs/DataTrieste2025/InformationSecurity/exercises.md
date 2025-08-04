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

If for any reason GPG is not installed, on Ubuntu and Debian, you can update the local repo index and install it by typing:

```bash!
$ sudo apt update
$ sudo apt install gnupg
```

In order to start using the GNUpg we first need to create a new keypair:

```bash!
$ gpg --gen-key
```

THe key is stored in an special databased placed at `/home/$USER/.gnupg/trustdb.gpg`. During the generation you should provide the user name and email address:

```bash!
gpg: directory '/home/$USER/.gnupg' created
gpg: keybox '/home/$USER/.gnupg/pubring.kbx' created
Note: Use "gpg --full-generate-key" for a full featured key generation dialog.

GnuPG needs to construct a user ID to identify your key.

Real name: USER NAME
Email address: $USER@DOMAIN.com
You selected this USER-ID:
    "USER NAME <$USER@DOMAIN.com>"

Change (N)ame, (E)mail, or (O)kay/(Q)uit? O
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
gpg: /home/$USER/.gnupg/trustdb.gpg: trustdb created
gpg: key DCEEF79B91A8A2BC marked as ultimately trusted
gpg: directory '/home/$USER/.gnupg/openpgp-revocs.d' created
gpg: revocation certificate stored as '/home/$USER/.gnupg/openpgp-revocs.d/0B02D50E37F5C9D6A4678200DCEEF79B91A8A2BC.rev'
public and secret key created and signed.

pub   rsa3072 2023-08-06 [SC] [expires: 2025-08-05]
      0B02D50E37F5C9D6A4678200DCEEF79B91A8A2BC
uid                      USER NAME <$USER@DOMAIN.com>
sub   rsa3072 2023-08-06 [E] [expires: 2025-08-05]

```

Now we can list the public keys installed in our keyring by typing the command: 

```bash!
$ gpg --list-keys 

gpg: checking the trustdb
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
gpg: next trustdb check due at 2025-08-05
/home/$USER/.gnupg/pubring.kbx
------------------------------
pub   rsa3072 2023-08-06 [SC] [expires: 2025-08-05]
      0B02D50E37F5C9D6A4678200DCEEF79B91A8A2BC
uid           [ultimate] USERNAME <$USER@DOMAIN.com>
sub   rsa3072 2023-08-06 [E] [expires: 2025-08-05]

```

We can also list the private keys installed in our system with the command: 

```bash!
$ gpg --list-secret-keys 
/home/$USER/.gnupg/pubring.kbx
------------------------------
sec   rsa3072 2023-08-06 [SC] [expires: 2025-08-05]
      0B02D50E37F5C9D6A4678200DCEEF79B91A8A2BC
uid           [ultimate] USERNAME <$USER@DOMAIN.com>
ssb   rsa3072 2023-08-06 [E] [expires: 2025-08-05]

```

We can also add the `--keyid-format short` switch to get a better output.


# Importing a Public Key to your trusted database

We will query this database anytime we want to encrypt a message or a file with another user's public key, thus, in order to add a new (public) key to our database we will use the following command: 

```bash!
$ gpg --import PUBLIC_KEY_PATH

gpg: key BB4D0AA51163282D: public key "Other User <OTHER_USERNAME@DOMAIN.com>" imported
gpg: Total number processed: 1
gpg:               imported: 1

```

We can also query public pgp key servers, for instance, the MIT, the OpenPGP, or the Ubuntu servers. In order to do so, one must run (you can import keys that you find by following the prompts): 

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

Determining the authenticity of the person providing you with their public key can be a challenge. In certain situations, it might be straightforward, such as when you are physically present together, exchanging keys with laptops open. This method is quite secure and ensures you receive the correct and legitimate key.

However, there are numerous instances where such direct contact is not feasible. Perhaps you don't know the other party personally or are separated by distance. In such cases, verifying the public key's authenticity without resorting to insecure channels can be difficult.

Fortunately, there is a solution that doesn't involve verifying the entire public keys of both parties. Instead, you can compare the "fingerprint" derived from these keys, which provides a reasonable level of assurance that both parties are using the same public key information.

To obtain the fingerprint of a public key, follow these steps: 

```bash!
$ gpg --fingerprint "USERNAME"
pub   rsa3072 2023-08-06 [SC] [expires: 2025-08-05]
      0B02 D50E 37F5 C9D6 A467  8200 DCEE F79B 91A8 A2BC
uid           [ultimate] USERNAME <$USER@DOMAIN.com>
sub   rsa3072 2023-08-06 [E] [expires: 2025-08-05]

```

You can also extract the fingerprint from a public key on a file: 

```bash!
$ gpg --show-keys --fingerprint PATH_TO_FILE 
pub   rsa3072 2023-08-06 [SC] [expires: 2025-08-05]
      5881 7366 9068 8BF3 A897  AF87 87E6 6264 F663 A9DD
uid                      OTHER_USERNAME <OTHER USERNAME@DOMAIN.com>
sub   rsa3072 2023-08-06 [E] [expires: 2025-08-05]
```

## Sign someone else's key

Signing a key serves as an indication of your trust in the provided key and confirms that you have verified its association with the individual in question.

To sign a key that you have imported, simply execute the following command:

```bash!
$ gpg --sign-key USERNAME@DOMAIN.com

pub  rsa3072/BB4D0AA51163282D
     created: 2023-08-06  expires: 2025-08-05  usage: SC  
     trust: unknown       validity: unknown
sub  rsa3072/5F772EEFF4BFAD23
     created: 2023-08-06  expires: 2025-08-05  usage: E   
[ unknown] (1). USERNAME <$USER@DOMAIN.com>


pub  rsa3072/BB4D0AA51163282D
     created: 2023-08-06  expires: 2025-08-05  usage: SC  
     trust: unknown       validity: unknown
 Primary key fingerprint: BC01 C448 CB61 7BBC 8772  2182 BB4D 0AA5 1163 282D

     USERNAME <$USER@DOMAIN.com>

This key is due to expire on 2025-08-05.
Are you sure that you want to sign this key with your
key "YOUR_USERNAME <$USER@DOMAIN.com>" (DCEEF79B91A8A2BC)

Really sign? (y/N) y
```

By signing the key, you express your confidence in the person's claimed identity, helping others make a decision about trusting that individual as well. If someone trusts you and notices that you have signed this person's key, they may be more inclined to trust their identity too.

Allowing the person whose key you are signing to benefit from your trusted relationship involves sending them back the signed key. To do this, use the following command:

```bash!
$ gpg --output /tmp/user1_signed_pub.asc --export --armor "user1@DOMAIN.com"
```
In order to list the signatures of a _User 1_ public key, one should run:

```bash!
$ gpg --list-signatures "User 1"
pub   rsa3072 2023-08-06 [SC] [expires: 2025-08-05]
      BC01C448CB617BBC87722182BB4D0AA51163282D
uid           [  full  ] User 1 <user1@DOMAIN.com>
sig 3        BB4D0AA51163282D 2023-08-06  User 1 <user1@DOMAIN.com>
sig          DCEEF79B91A8A2BC 2023-08-06  User 3 <user3@DOMAIN.com>
sub   rsa3072 2023-08-06 [E] [expires: 2025-08-05]
sig          BB4D0AA51163282D 2023-08-06  User 1 <user1@DOMAIN.com>
```

In the lines: 
```bash!
sig 3        BB4D0AA51163282D 2023-08-06  User 1 <user1@DOMAIN.com>
sig          DCEEF79B91A8A2BC 2023-08-06  User 3 <user3@DOMAIN.com>
```
One can see that the public key has been signed by both the "User 1" (the owner of the key) and by "User 3"

Now that _User 1_ has had his/her keys signed by _User 3_, _User 3_ can update his/her keys:

```bash!
$ gpg --import /tmp/user1_signed_pub.asc
```

# Publish your private key to a keyserver

The design of public key encryption ensures that there is no potential for malicious actions even if unknown individuals possess your public key.

Considering this, it can be advantageous to openly share your public key, as it allows people to access your information and communicate with you securely right from the outset.

To provide your public key to anyone, simply request it from the GPG system: 

```bash!
$ gpg --output ~/mygpg.key --armor --export $USER@DOMAIN.com

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
$ gpg --list-keys --keyid-format short $USER@DOMAIN.com

pub   rsa3072/91A8A2BC 2023-08-06 [SC] [expires: 2025-08-05]
      0B02D50E37F5C9D6A4678200DCEEF79B91A8A2BC
uid         [ultimate] USERNAME <$USER@DOMAIN.com>
sub   rsa3072/C8149F9C 2023-08-06 [E] [expires: 2025-08-05]
```

Then, we perform the upload: 

```bash!
$ gpg --send-keys --keyserver keys.openpgp.org 91A8A2BC
gpg: sending key DCEEF79B91A8A2BC to hkp://keys.openpgp.org
```

In the case of the OpenPGP server, it will send you a message in order to validate the email address on the key.


# Encrypting and Decrypting a message using the PGP protocol


To encrypt messages using GPG, you can use the "--encrypt" flag along with other options. The basic syntax is as follows:

```bash!
gpg --encrypt --sign --armor -r person@email.com name_of_file
```

This command performs the following actions: It encrypts the message using the recipient's public key, signs it with your private key to verify its origin, and presents the output in a text format rather than raw bytes. The resulting filename will be the same as the input filename, but with a .asc extension.

If you wish to read the encrypted message, remember to include a second "-r" recipient with your own email address. This is necessary because the message will be encrypted with each recipient's public key and can only be decrypted using the corresponding private key.

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

Now you can send the encrypted msg to another user and you will be sure that the other user will be the only one able to read the message. In order to do so, the other user should run the following command:

```bash!
$ gpg --decrypt --output file.txt  file.txt.asc 

gpg: encrypted with 3072-bit RSA key, ID 5F772EEFF4BFAD23, created 2023-08-06
      "User 1 <user1@gmail.com>"
gpg: Signature made dom 06 ago 2023 20:16:39 -03
gpg:                using RSA key 0B02D50E37F5C9D6A4678200DCEEF79B91A8A2BC
gpg: Good signature from "User 3 <user3@gmail.com>" [unknown]
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 0B02 D50E 37F5 C9D6 A467  8200 DCEE F79B 91A8 A2BC

```

The **Warning** message states that the person that signed the message is not trusted, i.e., you haven't signed the person's public key.

The fingerprint shown: `0B02 D50E 37F5 C9D6 A467  8200 DCEE F79B 91A8 A2BC` is the same from the _User 3_ public key:

```bash!
$ gpg --fingerprint "User 3"

pub   rsa3072 2023-08-06 [SC] [expires: 2025-08-05]
      0B02 D50E 37F5 C9D6 A467  8200 DCEE F79B 91A8 A2BC
uid           [ unknown] User 3 <user3@DOMAIN.com>
sub   rsa3072 2023-08-06 [E] [expires: 2025-08-05]

```
The `Good signature from` statement states that the file hasn't been altered since it was encrypted and signed.

## Generate separate signature file

In order to verify that the content of the file hasn't been altered after one can create a separate signature file by performing the following command: 

```bash!
$ gpg --output file.txt.sig --detach-sig file.txt
```

Now it is possible to verify that the content of the file hasn't changed:

```bash!
$ gpg --verify file.txt.sig file.txt
gpg: Signature made dom 06 ago 2023 20:31:41 -03
gpg:                using RSA key 0B02D50E37F5C9D6A4678200DCEEF79B91A8A2BC
gpg: Good signature from "User 3 <user3@DOMAIN.com>" [full]
```

If the file has been altered the message will look like:

```bash!
$ gpg --verify file.txt.sig file.txt
gpg: Signature made dom 06 ago 2023 20:31:41 -03
gpg:                using RSA key 0B02D50E37F5C9D6A4678200DCEEF79B91A8A2BC
gpg: BAD signature from "User 3 <user3@DOMAIN.com>" [full]
```

Also, if the identity of the signee can't be verifyied, i.e., we don't have access to the public key, we will see the following message: 

```bash!
$ gpg --verify file.txt.sig file.txt
gpg: Signature made dom 06 ago 2023 20:31:41 -03
gpg:                using RSA key 0B02D50E37F5C9D6A4678200DCEEF79B91A8A2BC
gpg: Can't check signature: No public key
```


# Exercises

1. Create your private key;
2. Collect as many signatures as possible from you coleagues
    * You can add you key to the [link](https://drive.google.com/drive/folders/1z5UMskD5PmKyfFfqSWpbK7n-obwDB0kz?usp=sharing) with the name `YOUR_FIRST_NAME_pub`, then, sign as many keys as you can and reupload the keys with the name `SOMEONE_FIRST_NAME_signed_YOUR_FIRST_NAME_pub`, e.g, a user name john includes the file `john_pub`, than another user named mary signs John's key and reupload it with the name`john_signed_mary_pub`.
3. Upload your key to the `openpgp` key server;
4. Pair with other students and exchange encrypted messages among yourselves;
5. Discover how to export your private key to take home with you; Use this [link](https://itslinuxfoss.com/export-gpg-private-key-and-public-key-file/#:~:text=To%20export%20a%20GPG%20private%20and%20public%20key%20to%20a,%E2%80%93list%2Dkeys%E2%80%9D%20command.) as reference;
6. What is a Revocation key? Why is it important to have one?
    * Read this [blog post](https://blog.chapagain.com.np/gpg-revoking-your-public-key-and-notifiying-key-server/).
