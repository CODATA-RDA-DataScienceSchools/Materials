# Information Security Exercises Answers
The commands are after the `$` sign.



## 1.
In order to generate your gpg key, run the following command:

```bash
$ gpg --gen-key
```

After running the command, you should provide it with your name and email adresse. After the completion of the command, you will see the following message:

```bash
gpg: key 6C98611CDD5F3CD4 marked as ultimately trusted
gpg: revocation certificate stored as '/home/user1/.gnupg/openpgp-revocs.d/06EDFAFB032E3DFFD52B7A6B6C98611CDD5F3CD4.rev'
public and secret key created and signed.

pub   rsa3072 2023-08-10 [SC] [expires: 2025-08-09]
      06EDFAFB032E3DFFD52B7A6B6C98611CDD5F3CD4
uid                      User 1 <user@blah.com>
sub   rsa3072 2023-08-10 [E] [expires: 2025-08-09]
```

## 2. 
In order to place our key in the shared folder, you have to first export it. 
Before exporting, we have to discover the _key id_ for the key that we want to export. Let's check what are the **public** keys that we have in our keychain:

```bash
$ gpg --list-keys --keyid-format short
```

The output should look somewhat like this, except that where it reads _User 1_ it should be your name followed by your email address:

```bash
pub   rsa3072/1163282D 2023-08-06 [SC] [expires: 2025-08-05]
      BC01C448CB617BBC87722182BB4D0AA51163282D
uid         [ultimate] User 1 <raphaelmcobe+gpguser1@gmail.com>
sub   rsa3072/F4BFAD23 2023-08-06 [E] [expires: 2025-08-05]
```

The first line of every entry in the list will show the key id, at the line that starts with `pub`. In this case, the keyid is `1163282D`. 
Now that we know what is the _key id_ of our public key, let's export it: 

```bash
$ gpg --export --armor --output pub_key.asc 1163282D
```
This command doesn't produce an output. It justs create the `pub_key.asc` file. The`--armor` switch tells the `gpg` command to export the key in an ASCII format instead of a binary file. This makes it easier to use an email system to send it to a coleague.
You can check the content of this key, by running:

```bash
$ cat pub_key.asc
```

The output should look similar to this: 

```bash
-----BEGIN PGP PUBLIC KEY BLOCK-----

mQGNBGTQALsBDACm4aBsap9wR8TCF6Q9VBgZ64mGjlFSCiXFZgioI/fVBPdikTUA
cQRiN4ADLQn4y75GZi8FfAZniNXib/O1w9W8zLGqP0wma1FyMKot5PCPGrVnJvUQ
vRRMWgdy8FfEAK9r/tYt6E+NQ6v/bs3HoWJJ29hncdYtVls+BaCLfjOp6HZjtbOv
sFwB9iLLnOnadpPaXWPGeknJLG3h6LamKHxWosASJT9KdHCaxq74Zn/IA7ZQhR6A
TtMAkg0tGoMXlSbbdjbdepS+L9CGOeTYWX/j2m+wckWRGSH7BGi6OiFSlG+7hxyY
...
-----END PGP PUBLIC KEY BLOCK-----

```

After exporting you public key, you can upload it to the [gooogle drive](https://drive.google.com/drive/folders/1z5UMskD5PmKyfFfqSWpbK7n-obwDB0kz?usp=sharing).

The second part of the exercise asks you to sign someone elses key. You have to go to the google drive shared folder and download one of you coleagues public key. 
Just make sure that you download a key that it hasn't been signed before (signed keys should have _signed_ in their file names).
After downloading a key you need to import it into you keychain. For example, if you downloaded a key from a person named _Riley_, the file should be named `riley_pub`. We can import such file by running:

```bash
$ gpg --import riley_pub.asc
```
The expected output should look like: 

```bash
gpg: key BC1063FB5DE6877D: public key "Riley <riley@domain.com>" imported
gpg: Total number processed: 1
gpg:               imported: 1
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   2  signed:   4  trust: 0-, 0q, 0n, 0m, 0f, 2u
gpg: depth: 1  valid:   4  signed:   0  trust: 3-, 0q, 0n, 0m, 1f, 0u
gpg: next trustdb check due at 2025-08-05

```
Where, in the first line, you should be able to see the name and the email address of your coleague.
After importing the key we are going to sign it. And to do that we first need to find what is the _key id_ that we just imported, thus we need to list all keys again:

```bash
$ gpg --list-keys --keyid-format short 
```

In this case, we will be able to see more than 1 output in the key listing. We have to find the correct key based on the name of the users which's key we want to sign:

```bash
...
pub   rsa3072/DD5F3CD4 2023-08-10 [SC] [expires: 2025-08-09]
      06EDFAFB032E3DFFD52B7A6B6C98611CDD5F3CD4
uid         [ultimate] John <John@blah.com>
sub   rsa3072/A9FB9DC7 2023-08-10 [E] [expires: 2025-08-09]

pub   rsa3072/5DE6877D 2023-08-06 [SC] [expires: 2025-08-05]
      400DF8F8E11AC850CBE63F60BC1063FB5DE6877D
uid         [  full  ] Riley <riley@domain.com>
sub   rsa3072/3E5B6093 2023-08-06 [E] [expires: 2025-08-05]

```

Back at our example scenario, we've just imported Riley's key. In this listing we can see the the key's id is `5DE6877D`. Now we know which key to sign. We do that by running the command:

```bash
$ gpg --sign-key 5DE6877D
```
In order to this command to complete you have to type the password of your private key (the one you created on exercise 1). Now we can export the signed key:

```bash
$ gpg --export --armor --output riley_signedby_raphael_pub.asc 5DE6877D
```

Now you have completed the signing of your coleague key. You can upload that file to the google drive.
Now, we want to update our publi key with it signed version by other students. We need to head to google drive and dowload the exported signed key and reimport it into our keychain.
For instance, if Riley has signed our public key and uploaded that to the google drive we can update our public key with the new signature by running: 

```bash
$ gpg --import raphael_signedby_riley_pub.asc
```

This command will produce an output that should state that there is a new signature on our key:

```bash
...
gpg: Total number processed: 1
gpg:         new signatures: 1
...
```

We can list the signatures by using this command (you have to figure out what is the key id of your public key. How do you do it? -tip: go back to the beginning of this exercise): 

```bash
$ gpg --list-signatures 5DE6877D
```

You should be able to see a line that starts with `sig` and contains the name and the email address of the person that signed the key:

```bash
sig          BB4D0AA51163282D 2023-08-06  Riley <riley@domain.com>
```

## 3.

In order to export our key to a key server we have to discover what is our _ key id_ (How would you do it?).
The command used for uploading a key to the openpgp server is:

```bash
$ gpg --send-keys --keyserver keys.openpgp.org 91A8A2BC
```
Where the `91A8A2BC` is is our _key id_.

After the competion of the command you should see the message: 
```bash
gpg: sending key DCEEF79B91A8A2BC to hkp://keys.openpgp.org
```
The openpgp key server sends a message to confirm the email address before making it online avalable. You need to check you email and follow the instructions from there.

## 4. 
First we need to create a new file to exchange with someone. We can use the `nano` text editor (you could use any text editor of your choice) -`nano` is available on Linux and Mac. 

```bash
$ nano message.txt
```

After writing the text within the file  we use the key combination `Ctrl+X` to exit the editor 
(don't forget to confirm that you want to save the file and what is the filename you want the changes to be saved to).

Now we can encrypt the file with the public key of a coleague that we already have imported into our keychain. This time we will use the coleague email address instead of his/her _key id_. 
If, for instance we are going to send _Riley_ a message and Riley's email address is `riley@domain.com` we need to run the command:

```bash
$ gpg --encrypt --armor -r "riley@domain.com" file.txt
```
The comman won't generate any output, but a new file will be created in the directory you are in named: `file.txt.asc`.

In case we've received the encrypted file and want to decrypt it, we need to run the command:

```bash
$ gpg --decrypt --output file.txt file.txt.asc
```

The output should look something like: 

```bash
gpg: encrypted with 3072-bit RSA key, ID 2E1F20E6D74CF66A, created 2023-08-06
      "Riley <riley@domain.com>"
```
Where in the bottom line you should be able to see the name and the email of the person that sent you the encrypted message. In this case, we've receied this file from _Riley_.

## 5.

In order to export your private key, we first need to discover our private _key id_. THus, we need to run the following:

```bash
$ gpg --list-secret-keys --keyid-format short
```

The result should look somewhat like this: 

```
/home/USER/.gnupg/pubring.kbx
-----------------------------
sec   rsa3072/91A8A2BC 2023-08-06 [SC] [expires: 2025-08-05]
      0B02D50E37F5C9D6A4678200DCEEF79B91A8A2BC
uid         [ultimate] USER_NAME <USER_EMAIL@DOMAIN.com>
ssb   rsa3072/C8149F9C 2023-08-06 [E] [expires: 2025-08-05]
```

In your output you should be able to see your Name on it is listed `USER_NAME` and your email where it is listed `USER_EMAIL`. In this case, the _key id_ for this private key is `91A8A2BC`.

Now we can export our private key by running the command:

```bash
$ gpg --export-secret-keys -a 91A8A2BC > prv.key
```

After running this command you will notice that a file named `prv.key` has been created in the current directory. This is your private key. **Be very carefull no to lose it**. Remember that this is a digital identity, thus, if it falls in the wrong hands, a lot of harm can be done.


## 6.

### Step 1: Download Installer & Signature

For example, on macOS download:

```bash
curl -OL https://github.com/keepassxreboot/keepassxc/releases/download/2.7.10/KeePassXC-2.7.10-x86_64.dmg
curl -OL https://github.com/keepassxreboot/keepassxc/releases/download/2.7.10/KeePassXC-2.7.10-x86_64.dmg.sig
```

### Step 2: Import KeePassXC Public Key

```bash
$ gpg --keyserver keys.openpgp.org --recv-keys BF5A669F2272CF4324C1FDA8CFB4C2166397D0D2
```

### Step 3: Verify the integrity
```bash
$ gpg --verify KeePassXC-*.sig
gpg: assuming signed data in 'KeePassXC-2.7.10-x86_64.dmg'
gpg: Signature made Tue Mar  4 00:51:12 2025 CET
gpg:                using RSA key C1E4CBA3AD78D3AFD894F9E0B7A66F03B59076A8
gpg: Good signature from "KeePassXC Release <release@keepassxc.org>" [unknown]
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: BF5A 669F 2272 CF43 24C1  FDA8 CFB4 C216 6397 D0D2
     Subkey fingerprint: C1E4 CBA3 AD78 D3AF D894  F9E0 B7A6 6F03 B590 76A8
```

### Optional step: Trust the downloaded key from the KeePassXC company

The Warning message says that we haven't trusted the downloaded key yet, so in order to do that we need to edit the downloaded key.

```bash
gpg --edit-key 6397D0D2
gpg (GnuPG) 2.4.5; Copyright (C) 2024 g10 Code GmbH
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.


pub  rsa4096/CFB4C2166397D0D2
     created: 2017-01-03  expires: never       usage: SC
     trust: full          validity: unknown
sub  rsa2048/B7A66F03B59076A8
     created: 2017-01-03  expires: 2028-12-08  usage: S
The following key was revoked on 2019-10-25 by RSA key CFB4C2166397D0D2 KeePassXC Release <release@keepassxc.org>
sub  rsa2048/AFF235EEFB5A2517
     created: 2017-01-03  revoked: 2019-10-25  usage: S
sub  rsa2048/D8538E98A26FD9C4
     created: 2017-01-03  expires: 2028-12-08  usage: S
[ unknown] (1). KeePassXC Release <release@keepassxc.org>
```
And now we are goint to use the trust command with the level of trust set to 5:

```bash
gpg> trust
pub  rsa4096/CFB4C2166397D0D2
     created: 2017-01-03  expires: never       usage: SC
     trust: full          validity: unknown
sub  rsa2048/B7A66F03B59076A8
     created: 2017-01-03  expires: 2028-12-08  usage: S
The following key was revoked on 2019-10-25 by RSA key CFB4C2166397D0D2 KeePassXC Release <release@keepassxc.org>
sub  rsa2048/AFF235EEFB5A2517
     created: 2017-01-03  revoked: 2019-10-25  usage: S
sub  rsa2048/D8538E98A26FD9C4
     created: 2017-01-03  expires: 2028-12-08  usage: S
[ unknown] (1). KeePassXC Release <release@keepassxc.org>

Please decide how far you trust this user to correctly verify other users' keys
(by looking at passports, checking fingerprints from different sources, etc.)

  1 = I don't know or won't say
  2 = I do NOT trust
  3 = I trust marginally
  4 = I trust fully
  5 = I trust ultimately
  m = back to the main menu

Your decision? 5
Do you really want to set this key to ultimate trust? (y/N) y

pub  rsa4096/CFB4C2166397D0D2
     created: 2017-01-03  expires: never       usage: SC
     trust: ultimate      validity: unknown
sub  rsa2048/B7A66F03B59076A8
     created: 2017-01-03  expires: 2028-12-08  usage: S
The following key was revoked on 2019-10-25 by RSA key CFB4C2166397D0D2 KeePassXC Release <release@keepassxc.org>
sub  rsa2048/AFF235EEFB5A2517
     created: 2017-01-03  revoked: 2019-10-25  usage: S
sub  rsa2048/D8538E98A26FD9C4
     created: 2017-01-03  expires: 2028-12-08  usage: S
[ unknown] (1). KeePassXC Release <release@keepassxc.org>
Please note that the shown key validity is not necessarily correct
unless you restart the program.
```
And finnaly, let's save our changes.

```bash
gpg> save
Key not changed so no update needed.
```

After that, if we recheck the integrity of the downloaded software we would get: 

```bash
gpg --verify KeePassXC-*.sig
gpg: assuming signed data in 'KeePassXC-2.7.10-x86_64.dmg'
gpg: Signature made Tue Mar  4 00:51:12 2025 CET
gpg:                using RSA key C1E4CBA3AD78D3AFD894F9E0B7A66F03B59076A8
gpg: checking the trustdb
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
gpg: Good signature from "KeePassXC Release <release@keepassxc.org>" [ultimate]
```

## 7.

A **revocation certificate** is a special file generated with your GPG key that allows you to declare the key invalid if it's ever lost, compromised, or no longer in use. It acts like a "kill switch" for your key: by publishing the revocation certificate, you notify others that your key should no longer be trusted. This is especially important if you lose access to your private key or forget your passphrase, as you would otherwise have no way to inform others not to use your public key for encryption or verification.

Generating a revocation certificate at the time you create your GPG key is considered best practice. The certificate itself should be stored securely—offline or in a protected backup—since using it immediately invalidates your key. In the event of compromise or key retirement, you can publish the revocation certificate to keyservers or distribute it manually to your contacts to maintain trust and security in your digital identity.
